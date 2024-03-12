import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_2/widgets/background.dart';
// import 'package:flutter_application_2/pages/waitingConfirmationPage.dart';
// import 'package:flutter_application_2/pages/transactionHistoryPage.dart';
// import 'package:flutter_application_2/widgets/appbar.dart';
import 'transactionHistoryPage.dart';
import '../widgets/components.dart';

class PaymentSuccessfulPage extends StatefulWidget {
  const PaymentSuccessfulPage({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<PaymentSuccessfulPage> createState() => _PaymentSuccessfulPageState();
}

class _PaymentSuccessfulPageState extends State<PaymentSuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return Scaffold(
      // appBar: myComponents.appBar(),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Color.fromARGB(255, 24, 70, 126),
                    size: 30,
                  )),
            ),
            Center(
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
                        "${widget.title}",
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
                        "Transaction Completed",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(44, 177, 230, 1),
                        ),
                      ),
                      Text(
                        "Payment Successful!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 30,
                          color: Color.fromARGB(239, 239, 139, 6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25, //space between PS & Container
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 222, 222),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTableRow('Amount', '-PHP 13.00'),
                            _buildTableRow('Ref Id', 'ORNZNXS8YX7JUYBXVA2'),
                            _buildTableRow(
                                'Route', 'BONI PINATUBO - STOP & SHOP'),
                            _buildTableRow('Date', '5/11/2020'),
                            _buildTableRow('Time', '3:13 PM'),
                            _buildTableRow('Status', 'PAID'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15, // Space between container and text
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionHistoryPage(
                                  title: 'Transaction History',
                                )),
                      );
                    },
                    child: Text(
                      "View Transaction History",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Color.fromRGBO(5, 81, 121, 1)),
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
            color: value == '-PHP 13.00'
                ? Colors.red
                : value == 'PAID'
                    ? const Color.fromRGBO(5, 81, 121, 1)
                    : const Color.fromRGBO(77, 76, 77, 1),
            fontSize: 15,
            fontStyle: value == 'PAID' ? FontStyle.italic : FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
