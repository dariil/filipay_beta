import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/components.dart';
import 'mainPage.dart';

class ClaimRewardsPage extends StatefulWidget {
  const ClaimRewardsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ClaimRewardsPageState createState() => _ClaimRewardsPageState();
}

class _ClaimRewardsPageState extends State<ClaimRewardsPage> {
  pageComponents myComponents = pageComponents();
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(title: widget.title),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(
                        // title: "Main Page",
                        ),
                  ),
                );
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
                SizedBox(
                  height: 1,
                ),
                SizedBox(
                  height: 70.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(83, 161, 216, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "You have received rewards!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromRGBO(5, 81, 121, 1),
                      ),
                    ),
                    SizedBox(
                      height: 30, //space between PS & Container
                    ),
                    Image.asset(
                      'assets/e-wallet/filipcoin.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 45, //space between image and button
                    ),
                    SizedBox(
                      width: 260,
                      height: 50,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _isPressed ? Color.fromRGBO(17, 119, 156, 1) : Color.fromRGBO(0, 173, 238, 1),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPressed = true;
                            });
                            // Simulate claim button logic
                            Future.delayed(Duration(milliseconds: 300), () {
                              setState(() {
                                _isPressed = false;
                              });
                              // Show a dialog when the button is pressed
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 50.0), // Adjust top padding as needed
                                      child: Text(
                                        'Reward Successfully Claimed!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                          child: Text(
                            'CLAIM',
                            style: TextStyle(
                              color: Color.fromRGBO(12, 46, 124, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
