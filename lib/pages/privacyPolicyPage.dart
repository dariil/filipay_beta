import 'package:flutter/material.dart';
import 'package:filipay_beta/widgets/components.dart';
import 'package:flutter/widgets.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Privacy Policy"),
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
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Last updated: August 1, 2023",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "This Privacy Policy describes how your personal information is collected, used, and shared when you use our mobile application (the \"App\").",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "1. Information We Collect:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. Personal Information: When you register for an account or use certain features of the App, we may collect personal information such as your name, email address, contact information, and payment details.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. Usage Data: We may collect information about how you interact with the App, including your IP address, device type, operating system, and browser type.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "c. Location Data: We may collect your device's location if you grant us permission, which helps us provide location-based features.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "d. User Content: Any content you provide through the App, such as posts, comments, or messages, may be collected and stored.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "2. How we use your information:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. Provide and Improve the App: We use your information to operate, maintain, and improve the App's features and services.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. Personalization: We may use your information to personalize your experience, such as showing relevant content and recommendations.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "c. Communication: We may use your contact information to send you updates, newsletters, and promotional materials. You can opt out of these communications.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "d. Analytics: We may use your data for analytics purposes to understand how users interact with the App, which helps us improve its functionality\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "3. Sharing Your Information:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. Third-Party Service Providers: We may share your information with third-party service providers to help us operate and improve the App, such as hosting, payment processing, and analytics.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. Legal Compliance: We may disclose your information to comply with applicable laws, regulations, legal processes, or government requests.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "c. Business Transfers: If the App undergoes a change in ownership, such as a merger or acquisition, your information may be transferred to the new owners.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "d. User Content: Your user-generated content may be shared with other users based on your privacy settings.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "4. Your Choices:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. Account Information: You can access and update your account information by logging into your account settings.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. Location Data: You can adjust your device's location settings to control whether we collect location data.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "c. Communications: You can opt out of receiving promotional communications by following the unsubscribe instructions in the email.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "5. Security:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. We implement security measures to protect your personal information, but no method of transmission over the internet or electronic storage is 100% secure.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. You are responsible for keeping your account credentials confidential. Please do not share your password with others.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "6. Children's Privacy:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. The App is not intended for users under the age of 13.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. We do not knowingly collect personal information from children under 13.\n",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "7. Changes to this Privacy Policy:\n",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "a. We may update this Privacy Policy from time to time to reflect changes in our practices or for legal, operational, or regulatory reasons.\n",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "b. We will notify you of any significant changes by posting the updated Privacy Policy within the App.\n",
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
