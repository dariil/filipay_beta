import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/components.dart';
import 'package:text_divider/text_divider.dart';

class UpgradeLimitsPage extends StatelessWidget {
  final String title;

  const UpgradeLimitsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              Align(
                alignment: Alignment.topLeft,
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                  color: Color.fromARGB(255, 24, 70, 126),
                  iconSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                              "UPGRADE YOUR LIMITS",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(239, 239, 139, 6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Container(
                        width: 330.0,
                        height: 40.0,
                        padding: EdgeInsets.all(7),
                        color: const Color.fromRGBO(151, 198, 231, 1),
                        alignment: Alignment.center,
                        child: Text(
                          "DAILY COMMUTER",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 70, 126),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: "Phone Verification ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(121, 121, 121, 1),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "(Mobile Number)",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                  ),
                                ),
                              ])),
                          Container(
                            width: 100.0,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(19, 233, 109, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "COMPLETED",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: "Email Verification ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(121, 121, 121, 1),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "(Email Address)",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                  ),
                                ),
                              ])),
                          Container(
                            width: 100.0,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(19, 233, 109, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "COMPLETED",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Center(
                      child: Container(
                        width: 330.0,
                        height: 40.0,
                        padding: EdgeInsets.all(7),
                        color: const Color.fromRGBO(151, 198, 231, 1),
                        alignment: Alignment.center,
                        child: Text(
                          "REGULAR TRAVELER",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 70, 126),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: "Identity Verification ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(121, 121, 121, 1),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "(Valid ID)",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                  ),
                                ),
                              ])),
                          SizedBox(
                            height: 30,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                                child: Text(
                                  "VERIFY",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: "Selfie Verification ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(121, 121, 121, 1),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "(Selfie with ID)",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                  ),
                                ),
                              ])),
                          SizedBox(
                            height: 30,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                                child: Text(
                                  "VERIFY",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(83, 161, 216, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Center(
                      child: Container(
                        width: 330.0,
                        height: 40.0,
                        padding: EdgeInsets.all(7),
                        color: const Color.fromRGBO(151, 198, 231, 1),
                        alignment: Alignment.center,
                        child: Text("BUSINESS",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 24, 70, 126),
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(TextSpan(
                                text: "Business Verification ",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(121, 121, 121, 1),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "(Business Permit)",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: const Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  ),
                                ])),
                          ),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                      color: const Color.fromRGBO(83, 161, 216, 1),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                                  child: Text(
                                    "VERIFY",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromRGBO(83, 161, 216, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    TextDivider(
                      color: Colors.black,
                      text: Text('LIMITS',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 70, 126),
                          )),
                    ),
                    SizedBox(height: 11),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(191, 227, 239, 1),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTableRow('Daily Commuter', '1,000'),
                                _buildTableRow('Regular Traveler', '10,000'),
                                _buildTableRow('Business', '50,000'),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color.fromRGBO(77, 76, 77, 1),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
