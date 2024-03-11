import 'package:flutter/material.dart';
import '../widgets/components.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _showPassword = false;
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  pageComponents myComponents = pageComponents();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4, // Set opacity to 0.4
              child: myComponents.background(), // Background widget
            ),
            Positioned(
              top: 57,
              left: 15,
              right: 15,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_sharp,
                            color: Color.fromARGB(255, 24, 70, 126),
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "CHANGE PASSWORD",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(239, 239, 139, 6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "Please don't share your password with anyone. ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(40, 52, 116, 1),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.lock,
                          color: Color.fromRGBO(40, 52, 116, 1),
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, bottom: 10),
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              height: 55,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                controller: _oldPasswordController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(40, 52, 116, 1)
                                          .withOpacity(0.5)),
                                  hintText: 'Old Password',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 5),
                                ),
                                obscureText: !_showPassword,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              alignment: Alignment.center,
                              height: 55,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                controller: _newPasswordController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(40, 52, 116, 1)
                                          .withOpacity(0.5)),
                                  hintText: 'New Password',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 5),
                                ),
                                obscureText: !_showPassword,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              alignment: Alignment.center,
                              height: 55,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(40, 52, 116, 1)
                                          .withOpacity(0.5)),
                                  hintText: 'Confirm Password',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                ),
                                obscureText: !_showPassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _showPassword,
                                onChanged: (value) {
                                  setState(() {
                                    _showPassword = value!;
                                  });
                                },
                              ),
                              Text(
                                'Show Password',
                                style: TextStyle(
                                  color: Color.fromRGBO(40, 52, 116, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(340, 50),
                            backgroundColor: Color.fromRGBO(40, 52, 116, 1)),
                        onPressed: () {
                          _savePassword();
                        },
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                    SizedBox(height: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePassword() {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (oldPassword.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (newPassword == confirmPassword) {
        _showSuccessDialog();
      } else {
        _showErrorDialog("New password and confirm password do not match.");
      }
    } else {
      _showErrorDialog("Please complete all fields.");
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Remove default padding
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/pass-success.gif',
                    height: 90, // Adjust image height as needed
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Password changed successfully!",
                    textAlign: TextAlign.center, // Center align text
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 52, 116, 1),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("\n$message"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
