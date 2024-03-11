import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'drawer.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});
  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  pageComponents myComponents = pageComponents();

  List<Map<String, dynamic>> bookingDetailsList = [
    {
      'amount': '1800.00',
      'referenceCode': 'R434TGERGFWEGEY4',
      'route': 'Alabang Starmall-Naga, Camarines Sur',
      'date': '02/19/2024',
      'time': '6:00',
    },
    {
      'amount': '1800.00',
      'referenceCode': 'R434TGERGFWEGEY4',
      'route': 'Alabang Starmall-Naga, Camarines Sur',
      'date': '02/19/2024',
      'time': '6:00',
    },
    {
      'amount': '1800.00',
      'referenceCode': 'R434TGERGFWEGEY4',
      'route': 'Alabang Starmall-Naga, Camarines Sur',
      'date': '02/19/2024',
      'time': '6:00',
    },
  ];

  double verticalPadding = 10.0;
  double horizontalPadding = 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      // drawer: NavDrawer(),
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
                      itemCount: bookingDetailsList.length +
                          1, // Add 1 for the "View More" button
                      itemBuilder: (context, index) {
                        if (index < bookingDetailsList.length) {
                          // Build the regular list item
                          return Container(
                            padding:
                                EdgeInsets.symmetric(vertical: verticalPadding),
                            child: myComponents.coloredBackground(
                              color: Color.fromRGBO(43, 177, 230, 0.4),
                              childWidget: myComponents.bookingDetails(
                                context,
                                "${bookingDetailsList[index]['amount']}",
                                "R434TGERGFWEGEY4",
                                "Alabang Starmall-Naga, Camarines Sur",
                                "02/19/2024",
                                "6:00",
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
