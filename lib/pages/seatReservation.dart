import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import '../widgets/components.dart';
import '../src/util/time_range.dart';
import '../functions/functions.dart';
import 'package:intl/intl.dart';

class SeatReservation extends StatefulWidget {
  const SeatReservation({super.key});

  @override
  State<SeatReservation> createState() => _SeatReservationState();
}

class _SeatReservationState extends State<SeatReservation> {
  final _filipay = Hive.box("filipay");
  static const orange = Color(0xFF00adee);
  static const dark = Color(0xFF00adee);

  pageComponents myComponents = pageComponents();
  List<bool> seatSelected = List.generate(47, (index) => false);
  bool _isLoading = false;
  int selectedSeatCount = 0;
  double price = 0.0;
  pageFunctions myFunc = pageFunctions();
  List<int> selectedSeats = [];

  List<Widget> generateSeats(int count) {
    final userBookings = _filipay.get('tbl_bookings');
    final userReservation = _filipay.get('tbl_seat_reservation');
    List<Widget> seats = [];
    List<Widget> rowSeats = [];

    int seatNumber = 1;
    double seatWidth = 25.0;
    double seatHeight = 25.0;

    for (int i = 0; i < count; i++) {
      bool isSeatAvailable(int seatNumber, String currentDate) {
        // Check if seat is available for the given date
        bool isAvailable = true;
        for (var reservation in userReservation) {
          if (reservation['time'] == currentDate &&
              reservation['seat_number'].contains(seatNumber)) {
            isAvailable = false;
            break;
          }
        }
        // Check if seat is booked for the given date
        for (var booking in userBookings) {
          if (booking['date'] == currentDate &&
              booking['seat_reservation_id'] != null &&
              userReservation[booking['seat_reservation_id']]['seat_number']
                  .contains(seatNumber)) {
            isAvailable = false;
            break;
          }
        }
        return isAvailable;
      }

      String currentDate =
          myFunc.dateSelected; // Change this to the selected date
      bool isAvailable = isSeatAvailable(seatNumber, currentDate);

      Color seatColor = isAvailable ? Color(0xff53a1d8) : Color(0xffb5e0fe);

      rowSeats.add(
        GestureDetector(
          onTap: () {
            if (isAvailable) {
              setState(() {
                seatSelected[i] = !seatSelected[i];
                if (seatSelected[i]) {
                  selectedSeatCount++;
                  price += 900;
                  selectedSeats.add(i + 1); // Add selected seat number
                } else {
                  selectedSeatCount--;
                  price -= 900;
                  selectedSeats.remove(i + 1); // Remove deselected seat number
                }
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: seatSelected[i] ? Color(0xffef8b06) : seatColor,
              ),
              width: seatWidth,
              height: seatHeight,
              child: Center(
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage("assets/general/bus-seat.png"),
                    ),
                    Center(
                      child: Text(
                        '$seatNumber',
                        style: TextStyle(
                          color: isAvailable ? Colors.white : Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      int column = calculateColumn(i, seatNumber);

      if (hasSpace(column, seatNumber)) {
        rowSeats.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 3.0),
            child: Container(
              width: seatWidth,
              height: seatHeight,
              color: Colors.transparent,
            ),
          ),
        );
      }

      if (shouldAddRow(column, i, count)) {
        seats.add(
          Container(
            margin: EdgeInsets.only(
                left: ((MediaQuery.of(context).size.width * 0.90 - 30.0) / 2 -
                    80.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: rowSeats.reversed.toList(),
            ),
          ),
        );
        rowSeats = [];
      }
      seatNumber++;
    }
    return seats;
  }

  int calculateColumn(int i, int seatNumber) {
    if (seatNumber > 42) {
      return 5 - ((i + 2) % 4);
    } else if (seatNumber > 22) {
      return 4 - ((i + 2) % 4);
    } else if (seatNumber < 21) {
      return 4 - (i % 4);
    } else if (seatNumber == 21 || seatNumber == 22) {
      return 2 - (i % 2);
    }
    return 0;
  }

  bool hasSpace(int column, int seatNum) {
    if (seatNum > 42) {
      return column == 0;
    }
    return column == 3;
  }

  bool shouldAddRow(int column, int i, int count) {
    return column == 1 || i == count - 1;
  }

  void setTrue() {
    setState(() {
      _isLoading = true;
    });
  }

  void loadingConnect() {
    final userBookings = _filipay.get('tbl_bookings');
    final userReservation = _filipay.get('tbl_seat_reservation');
    setTrue();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        myComponents.bookConfirmation(
          context,
          () {
            Navigator.pop(context);
            if (myFunc.reservedTime == "N/A") {
              setTrue();
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _isLoading = false;
                });
                myComponents.error(context, "No time selected",
                    "Please select a time and try again.");
              });
            } else if (selectedSeatCount < 1) {
              setTrue();
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _isLoading = false;
                });
                myComponents.error(context, "No seat(s) selected",
                    "Please select a seat and try again.");
              });
            } else {
              setState(() {
                setTrue();
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    _isLoading = false;

                    /// ADD HERE
                    int index = userReservation.indexWhere((user) =>
                        user['booking_id'] == (myFunc.active_booking_id));
                    userReservation[index]['time'] = myFunc.reservedTime;
                    userReservation[index]['quantity'] = selectedSeatCount;
                    userReservation[index]['seat_number'] = selectedSeats;
                    userReservation[index]['price'] = price;
                    _filipay.put(
                        'tbl_seat_reservation', myFunc.tbl_seat_reservation);

                    ///
                    myComponents.bookSuccessful(
                        context,
                        "Alabang Starmall-Naga, Camarines Sur",
                        "Friday 05/07/2021 11:30 pm",
                        price);
                    myFunc.active_booking_id = -1;
                    myFunc.reservedTime = "N/A";
                    myFunc.dateSelected = "N/A";
                    myFunc.headerDateSelected = "N/A";
                  });
                });
              });
            }
          },
          () {
            Navigator.pop(context);
          },
          "Confirm booking?",
          "The reflected fare will be deducted immediately and cannot be refunded. Are you sure you want to continue?",
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: myComponents.background(),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myComponents.headerPageLabel(
                      context, "${myFunc.headerDateSelected}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Trip Schedule",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff00adee),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey),
                          left: BorderSide(width: 1.0, color: Colors.grey),
                          right: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimeRange(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          activeTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          borderColor: orange,
                          backgroundColor: Colors.transparent,
                          activeBackgroundColor: dark,
                          firstTime: TimeOfDay(hour: 00, minute: 30),
                          lastTime: TimeOfDay(hour: 24, minute: 30),
                          timeStep: 180,
                          timeBlock: 30,
                          onRangeCompleted: (range) =>
                              setState(() => print(range)),
                          onFirstTimeSelected: (startHour) {
                            DateTime dateTime = DateTime(
                                2022, 1, 1, startHour.hour, startHour.minute);
                            String formattedTime =
                                DateFormat('hh:mm a').format(dateTime);
                            // setState(() => print("$formattedTime"));
                            setState(() {
                              myFunc.reservedTime = "$formattedTime";
                              print(myFunc.reservedTime);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff00adee),
                          ),
                        ),
                        Text(
                          "Time",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff00adee),
                          ),
                        ),
                        Text(
                          "Qty",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff00adee),
                          ),
                        ),
                        Text(
                          "Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff00adee),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${myFunc.dateSelected}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0c3c6d),
                          ),
                        ),
                        Text(
                          myFunc.reservedTime,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0c3c6d),
                          ),
                        ),
                        Text(
                          "${selectedSeatCount}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0c3c6d),
                          ),
                        ),
                        Text(
                          "₱${price}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0c3c6d),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                width: 15.0,
                                height: 15.0,
                                decoration: BoxDecoration(
                                  color: Color(0xff53a1d8),
                                ),
                              ),
                              Text("Available"),
                              SizedBox(width: 15.0),
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                width: 15.0,
                                height: 15.0,
                                decoration: BoxDecoration(
                                  color: Color(0xffb5e0fe),
                                ),
                              ),
                              Text("Occupied"),
                              SizedBox(width: 15.0),
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                width: 15.0,
                                height: 15.0,
                                decoration: BoxDecoration(
                                  color: Color(0xffef8b06),
                                ),
                              ),
                              Text("Chosen Seats"),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          children: generateSeats(47),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadingConnect();
                    },
                    text: "CONFIRM",
                    BackgroundColor: Color(0xff2e3191),
                    padding:
                        EdgeInsets.symmetric(horizontal: 130.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            Center(
              child: _isLoading
                  ? myComponents.simulateLoading(
                      context: context, loadText: "Please wait...")
                  : Text(''),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////
// This is temporary as I have isolated this file from the project flow
void main() {
  runApp(MaterialApp(
    home: SeatReservation(),
  ));
}
