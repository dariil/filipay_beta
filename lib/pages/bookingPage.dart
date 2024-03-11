import 'package:flutter/material.dart';
// import '../widgets/background.dart';
// import 'package:flutter_application_2/pages/mainPage.dart';
// import 'package:flutter_application_2/widgets/appbar.dart';
import 'package:intl/intl.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';

import 'bookings.dart';
import 'seatReservation.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    Key? key,
  }) : super(key: key);

  @override
  _BookingPage createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage> {
  pageComponents myComponents = pageComponents();
  pageFunctions myFunc = pageFunctions();
  String _selectedCompany = 'Bicol Isarog Transport System, Inc.';
  String _selectedRoute = 'SELECT A ROUTE';
  String _selectedOrigin = 'SELECT AN ORIGIN';
  String _selectedDestination = 'SELECT A DESTINATION';
  String _companyImage = 'assets/transportation/bicol-isarog-logo.png';

  DateTime? _selectedDate;

  void _handleCompanySelection(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedCompany = newValue;
        switch (newValue) {
          case 'Cavite Transport System, Inc.':
            _companyImage = 'assets/transportation/cavite-logo.png';
            break;
          case 'Bicol Isarog Transport System, Inc.':
            _companyImage = 'assets/transportation/bicol-isarog-logo.png';
            break;
          case 'Sucat Transport System, Inc.':
            _companyImage = 'assets/transportation/sucat-logo.png';
            break;
          case 'Laguna Transport System Inc.':
            _companyImage = 'assets/transportation/laguna-logo.png';
            break;
          default:
            _companyImage = 'assets/transportation/default-logo.png';
            break;
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  Color.fromRGBO(239, 139, 6, 1), // header background color
              onPrimary:
                  Color.fromARGB(255, 255, 255, 255), // header text color
              surface: const Color.fromARGB(255, 255, 255, 255),
              onSurface:
                  const Color.fromARGB(255, 30, 30, 30), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromRGBO(24, 70, 126, 1),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        myFunc.dateSelected =
            "${DateFormat('MM/dd/yyyy').format(_selectedDate!)}";
        myFunc.headerDateSelected =
            "${DateFormat('E, MMMM dd, yyyy').format(_selectedDate!)}";
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeatReservation()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        // appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
        // drawer: NavDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: 0.3,
                  child: myComponents.background(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Color.fromARGB(255, 24, 70, 126),
                    size: 30,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(83, 161, 216, 1),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color.fromRGBO(24, 70, 126, 1),
                            width: 3,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            _companyImage,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 350,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromRGBO(24, 70, 126, 1),
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/transportation/jeepney-bordered.png',
                                      width: 30,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              DropdownButtonHideUnderline(
                                child: Container(
                                  width: 350,
                                  child: DropdownButton<String>(
                                    value: _selectedCompany,
                                    icon: Container(
                                      padding: EdgeInsets.only(right: 1),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color.fromRGBO(83, 161, 216, 1),
                                      ),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromRGBO(40, 52, 116, 1),
                                      ),
                                    ),
                                    items: <String>[
                                      'Bicol Isarog Transport System, Inc.',
                                      'Sucat Transport System, Inc.',
                                      'Cavite Transport System, Inc.',
                                      'Laguna Transport System Inc.',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: _handleCompanySelection,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 345,
                          height: 210,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(224, 242, 255, 1),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Table(
                              columnWidths: {
                                0: FlexColumnWidth(0.3),
                                1: FlexColumnWidth(0.4),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text('ROUTE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  51, 51, 51, 1))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Container(
                                        height: 40,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedRoute,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Color.fromRGBO(
                                                  40, 52, 116, 1),
                                            ),
                                            items: <String>[
                                              'SELECT A ROUTE',
                                              'Route 2',
                                              'Route 3'
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          83, 161, 216, 1)),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedRoute = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(children: [
                                  TableCell(
                                    child: Divider(
                                      color: Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  ),
                                  TableCell(
                                    child: Divider(
                                      color: Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  )
                                ]),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'ORIGIN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(51, 51, 51, 1)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Container(
                                        height: 40,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedOrigin,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Color.fromRGBO(
                                                  40, 52, 116, 1),
                                            ),
                                            items: <String>[
                                              'SELECT AN ORIGIN',
                                              'Origin 2',
                                              'Origin 3'
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          83, 161, 216, 1)),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedOrigin = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(children: [
                                  TableCell(
                                    child: Divider(
                                      color: Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  ),
                                  TableCell(
                                    child: Divider(
                                      color: Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  )
                                ]),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'DESTINATION',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(51, 51, 51, 1)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Container(
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: _selectedDestination,
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Color.fromRGBO(
                                                    40, 52, 116, 1),
                                              ),
                                              items: <String>[
                                                'SELECT A DESTINATION',
                                                'Destination 2',
                                                'Destination 3'
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            83, 161, 216, 1)),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedDestination =
                                                      newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(children: [
                                  TableCell(
                                    child: Divider(
                                      color: Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  ),
                                  TableCell(
                                    child: Divider(
                                      color: Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyBookingsPage()));
                              },
                              child: Text(
                                'MY BOOKINGS',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 51, 102, 1)),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(0, 51, 102, 1),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      SizedBox(height: 1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                _selectDate(context); // Show calendar
                              },
                              child: Text(
                                'RESERVE A SEAT',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 51, 102, 1)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(83, 161, 216, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5), // Add space between buttons
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
