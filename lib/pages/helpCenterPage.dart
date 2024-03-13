import 'package:flutter/material.dart';
import 'package:filipay_beta/widgets/blurContainer.dart';
import 'package:filipay_beta/widgets/helpCenterappbar.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:filipay_beta/pages/ResponsePage.dart';
import 'package:filipay_beta/pages/newChatPage.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  double _horizontalPosition = 50;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: BlurContainer(),
                ),
                Positioned(
                  top: 45,
                  left: _horizontalPosition,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(
                            "Hello there, Jhon!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 35,
                  left: _horizontalPosition + 250,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _horizontalPosition += details.delta.dx;
                      });
                    },
                    child: Image.asset(
                      'assets/general/filipay-chat.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Positioned(
                  top: 75,
                  left: 0,
                  right: 80,
                  child: Center(
                    child: Text(
                      "How can we help you today?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Select a topic\nor type a question below.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromRGBO(241, 151, 45, 1),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResponseChatPage(
                                    title: "Filipay Card Stores",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 280,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(181, 225, 238, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: GradientBoxBorder(
                                  width: 3,
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(174, 212, 182, 1),
                                    Color.fromRGBO(83, 151, 178, 1),
                                    Color.fromRGBO(10, 136, 187, 1),
                                  ]),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(
                                    'assets/general/filipay-card-icon.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Filipay Card Stores",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 28, 28, 65),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResponseChatPage(
                                    title: "Reservation Tracking",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 280,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(181, 225, 238, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: GradientBoxBorder(
                                  width: 3,
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(174, 212, 182, 1),
                                    Color.fromRGBO(83, 151, 178, 1),
                                    Color.fromRGBO(10, 136, 187, 1),
                                  ]),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(
                                    'assets/general/reservation-icon.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Reservation Tracking",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 28, 28, 65),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResponseChatPage(
                                    title: "Top Up Load",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 280,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(181, 225, 238, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: GradientBoxBorder(
                                  width: 3,
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(174, 212, 182, 1),
                                    Color.fromRGBO(83, 151, 178, 1),
                                    Color.fromRGBO(10, 136, 187, 1),
                                  ]),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(
                                    'assets/general/topup-icon.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Top Up Load",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 28, 28, 65),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 99,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.maxFinite,
                height: 55,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 225, 238, 1)
                      .withOpacity(0.5), // Adjust opacity and color as needed
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Start a Conversation...',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(241, 151, 45, 1),
                        ),
                        child: IconButton(
                          onPressed: () {
                            final message = _controller.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewChatPage(
                                    title:
                                        message), //To push the message to newChatPage
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.send,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
