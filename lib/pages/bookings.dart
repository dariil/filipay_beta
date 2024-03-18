import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});
  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  pageComponents myComponents = pageComponents();
  pageFunctions myFunc = pageFunctions();
  final _filipay = Hive.box("filipay");

  List<Map<String, dynamic>> tbl_bookings = [
    {
      "booking_id": 4,
      "seat_reservation_id": 20,
      "user_id": 0,
      "reference_code": "TY5H6TW5T565YE",
      "route": "Sample Route 1",
      "date": "03/01/2024",
      "status": "COMPLETED",
    },
    {
      "booking_id": 0,
      "seat_reservation_id": 1,
      "user_id": 1,
      "reference_code": "TY5H6TW5T565YE",
      "route": "Sample Route 1",
      "date": "03/18/2024",
      "status": "PENDING",
    },
    {
      "booking_id": 0,
      "seat_reservation_id": 0,
      "user_id": 0,
      "reference_code": "0TIGJRO54P3444D",
      "route": "Sample Route 2",
      "date": "02/24/2024",
      "status": "COMPLETED",
    },
  ];

  List<Map<String, dynamic>> tbl_seat_reservation = [
    {
      "seat_reservation_id": 20,
      "time": "11:30 AM",
      "quantity": 1,
      "seat_number": [18],
      "price": 900
    },
    {
      "seat_reservation_id": 1,
      "time": "9:30 PM",
      "quantity": 3,
      "seat_number": [18],
      "price": 2700
    },
    {
      "seat_reservation_id": 0,
      "time": "3:30 PM",
      "quantity": 2,
      "seat_number": [6, 5],
      "price": 1800
    },
  ];

  double verticalPadding = 10.0;
  double horizontalPadding = 30.0;

  String getTime(int seatReservationId) {
    final seatReservationList = _filipay.get('tbl_seat_reservation');
    myFunc.tbl_seat_reservation =
        List<Map<dynamic, dynamic>>.from(seatReservationList);
    return myFunc.tbl_seat_reservation.firstWhere((element) =>
        element['seat_reservation_id'] == seatReservationId)['time'];
  }

  int getPrice(int seatReservationId) {
    final seatReservationList = _filipay.get('tbl_seat_reservation');
    myFunc.tbl_seat_reservation =
        List<Map<dynamic, dynamic>>.from(seatReservationList);
    return myFunc.tbl_seat_reservation.firstWhere((element) =>
        element['seat_reservation_id'] == seatReservationId)['price'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            myComponents.headerPageLabel(context, "My Bookings"),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: myComponents.background(),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: ListView.builder(
                      itemCount: myFunc.tbl_bookings
                              .where((booking) =>
                                  booking['user_id'] == myFunc.current_user_id)
                              .length +
                          1,
                      itemBuilder: (context, index) {
                        final filteredBookings = myFunc.tbl_bookings
                            .where((booking) =>
                                booking['user_id'] == myFunc.current_user_id)
                            .toList();
                        if (index < filteredBookings.length) {
                          final booking = filteredBookings[index];
                          final time = getTime(booking['seat_reservation_id']);
                          final price =
                              getPrice(booking['seat_reservation_id']);
                          return Container(
                            padding:
                                EdgeInsets.symmetric(vertical: verticalPadding),
                            child: myComponents.coloredBackground(
                              color: Color.fromRGBO(43, 177, 230, 0.4),
                              childWidget: myComponents.bookingDetails(
                                context,
                                "${price}",
                                "${booking['reference_code']}",
                                "${booking['route']}",
                                "${booking['date']}",
                                "${time}",
                              ),
                            ),
                          );
                        } else {
                          return Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "View More >>",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
