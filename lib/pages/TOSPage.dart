import 'package:flutter/material.dart';
import 'package:filipay_beta/widgets/components.dart';

class TOS extends StatefulWidget {
  const TOS({super.key});

  @override
  State<TOS> createState() => _TOSState();
}

class _TOSState extends State<TOS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Terms of Service"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    width: 150.0,
                    height: 150.0,
                    child: Image(
                      image: AssetImage(
                        'assets/general/filipay-logo-w-name.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Terms and Conditions. Please read these terms and conditions carefully before using our app",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    "1. Acceptance of Terms By accessing or using our app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, please do not use the app.\n",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "2. User Registration and Account:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. To use certain features of the app, you may need to register for an account. You are responsible for keeping your account information secure and up-to-date.\n\nb. You must be at least 18 years old to create an account and use the app.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "3. Privacy and Data Collection:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. We respect your privacy and are committed to protecting your personal information. Please review our Privacy Policy to understand how we collect, use, and disclose your data.\n\nb. By using the app, you consent to the collection and use of your data as described in our Privacy Policy.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "4. User Content:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. You may have the ability to submit, post, or share content through the app. You are solely responsible for any content you contribute and its legality.\n\nb. We have the right to monitor, remove, or modify user-generated content that violates these terms.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "5. Intellectual Property:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. The app's content, design, and functionality are owned by us and are protected by copyright, trademark, and other intellectual property laws.\n\nb. You may not reproduce, distribute, modify, or create derivative works based on our app without our explicit permission.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "6. Prohibited Conduct:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. You agree not to engage in any conduct that could harm, disable, overburden, or impair the app's functionality or interfere with other users' access.\n\nb. You may not use the app for any illegal or unauthorized purpose.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "7. Changes to Terms and App:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. We reserve the right to modify or terminate the app, its features, or these terms at any time without notice.\n\nb. Continued use of the app after changes to the terms constitutes your acceptance of the revised terms.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "8. Limitation of Liability:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. We make no warranties or representations about the accuracy or completeness of the app's content. \n\nb. In no event shall we be liable for any direct, indirect, punitive, incidental, special, or consequential damages.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "9. Governing Law and Dispute Resolution:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. These terms and conditions are governed by the laws of your jurisdiction. \n\nb. Any disputes arising out of or related to the use of the app will be subject to binding arbitration.\n",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Contact Us If you have any questions or concerns about these terms, please contact us at support@example.com. By using the app, you agree to these terms and conditions.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Last updated: August 1, 2023.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "UNDERSTOOD",
                    BackgroundColor: Color.fromRGBO(47, 50, 145, 1.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    BorderRadius: BorderRadius.circular(50.0),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ));
  }
}
