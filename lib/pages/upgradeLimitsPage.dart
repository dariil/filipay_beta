import 'package:flutter/material.dart';
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
              padding: EdgeInsets.symmetric(vertical: 65, horizontal: 15),
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
              child: Column(
                children: [
                  SizedBox(height: 65),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 50),
                      Text(
                        "UPGRADE YOUR LIMITS",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(239, 239, 139, 6),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          // Add functionality for the icon press here (optional)
                        },
                        color: Color.fromARGB(255, 24, 70, 126),
                        iconSize: 30,
                      ),
                    ],
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 70, 126),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Phone Verification ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(121, 121, 121, 1),
                        ),
                      ),
                      Text(
                        "(Mobile Number)",
                        style: TextStyle(
                          fontSize: 9,
                          color: const Color.fromRGBO(83, 161, 216, 1),
                        ),
                      ),
                      SizedBox(width: 40),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(19, 233, 109, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Add functionality for the container press here
                          },
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
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email Verification ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(121, 121, 121, 1),
                        ),
                      ),
                      Text(
                        "(Email Address) ",
                        style: TextStyle(
                          fontSize: 9,
                          color: const Color.fromRGBO(83, 161, 216, 1),
                        ),
                      ),
                      SizedBox(width: 45),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(19, 233, 109, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Add functionality for the container press here
                          },
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
                    ],
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 70, 126),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Identity Verification ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(121, 121, 121, 1),
                        ),
                      ),
                      Text(
                        "(Valid ID)",
                        style: TextStyle(
                          fontSize: 9,
                          color: const Color.fromRGBO(83, 161, 216, 1),
                        ),
                      ),
                      SizedBox(width: 65),
                      SizedBox(
                        height: 30, // Adjust the height as needed
                        child: OutlinedButton(
                          onPressed: () {
                            // Add functionality for the button press here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust border radius here
                              ),
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: const Color.fromRGBO(83, 161, 216, 1),
                                width: 1, // Adjust border width if needed
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1,
                                horizontal: 2), // Adjust padding as needed
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
                  SizedBox(height: 10), // Add spacing
                  // Another Row for Email Verification and Completed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Selfie Verification ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(121, 121, 121, 1),
                        ),
                      ),
                      Text(
                        "(Selfie with ID) ",
                        style: TextStyle(
                          fontSize: 9,
                          color: const Color.fromRGBO(83, 161, 216, 1),
                        ),
                      ),
                      SizedBox(width: 55),
                      SizedBox(
                        height: 30, // Adjust the height as needed
                        child: OutlinedButton(
                          onPressed: () {
                            // Add functionality for the button press here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust border radius here
                              ),
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: const Color.fromRGBO(83, 161, 216, 1),
                                width: 1, // Adjust border width if needed
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1,
                                horizontal: 2), // Adjust padding as needed
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
                  SizedBox(height: 14), // Add spacing
                  Center(
                    child: Container(
                      width: 330.0,
                      height: 40.0,
                      padding: EdgeInsets.all(7),
                      color: const Color.fromRGBO(151, 198, 231, 1),
                      alignment: Alignment.center,
                      child: Text("BUSINESS",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 70, 126),
                          )),
                    ),
                  ),
                  SizedBox(height: 10), // Add spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Business Verification ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(121, 121, 121, 1),
                        ),
                      ),
                      Text(
                        "(Business Permit)",
                        style: TextStyle(
                          fontSize: 9,
                          color: const Color.fromRGBO(83, 161, 216, 1),
                        ),
                      ),
                      SizedBox(width: 26),
                      SizedBox(
                        height: 30,
                        child: OutlinedButton(
                          onPressed: () {
                            // Add functionality for the button press here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 2),
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
                  SizedBox(height: 18), // Add spacing
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(191, 227, 239, 1),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
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
