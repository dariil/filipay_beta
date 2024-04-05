import 'package:flutter/material.dart';

import 'paymentSuccessfulPage.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';

class WaitingConfirmationPage extends StatefulWidget {
  const WaitingConfirmationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WaitingConfirmationPage> createState() => _WaitingConfirmationPageState();
}

class _WaitingConfirmationPageState extends State<WaitingConfirmationPage> {
  pageFunctions pageFunc = pageFunctions();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentSuccessfulPage(title: '${pageFunc.transportMode}')));
    });
  }

  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.3,
              child: myComponents.background(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessfulPage(
                      title: 'Payment Successful',
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.title}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(239, 239, 139, 6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "waiting for confirmation..",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(44, 177, 230, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 222, 222),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTableRow('Reference Code', 'ORNZNXS8YX7JUYBXVA2'),
                            _buildTableRow('Departure', 'WEB FEB 26 3:18 PM'),
                            _buildTableRow('Origin', 'STOP & SHOP T.'),
                            _buildTableRow('Destination', 'SAN JOAQUIN'),
                            _buildTableRow('Route', 'BONI PINATUBO - STOP & SHOP'),
                            _buildTableRow('Status', 'PENDING VALIDATION'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "View Transaction History",
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Color.fromRGBO(5, 81, 121, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Image.asset(
                          'assets/general/loading-confirmation.gif',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String header, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(
            color: const Color.fromRGBO(77, 76, 77, 1),
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color.fromRGBO(77, 76, 77, 1),
            fontSize: 15,
            fontStyle: value == 'PENDING VALIDATION' ? FontStyle.italic : FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
