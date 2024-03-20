// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(44, 177, 230, 1),
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/general/filipay-logo.png'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 65.0),
                  child: Text(
                    'Help Center',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 24, 70, 126),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.question_mark,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    constraints: BoxConstraints(maxWidth: 250, maxHeight: 250),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/general/chat-support-popup.png', // Change path as needed
                          width: 70, // Adjust width as needed
                          height: 70, // Adjust height as needed
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(40, 52, 116, 1),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Feel free to reach out to our\n support team for assistance.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Our team is available from",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "9:00 AM - 6:00 PM",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(241, 151, 45, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
