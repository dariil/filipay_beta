import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/components.dart';
import 'enterAmount.dart';
import 'drawer.dart';

class SelectAmountPage extends StatefulWidget {
  const SelectAmountPage({super.key});

  @override
  State<SelectAmountPage> createState() => _SelectAmountPageState();
}

class _SelectAmountPageState extends State<SelectAmountPage> {
  double loadAmount = 500.00;
  bool _isLoading = false;
  String username = "[name]";
  double limit = 10000;

  void loadingEnter() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EnterAmountPage()),
      );
    });
  }

  void setTrue(){
    setState((){
      _isLoading = true;
    });
  }

  void loadingConnect() {
    setTrue();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        myComponents.slider(
          context, 
          () {
            Navigator.pop(context);
            setState(() { 
              setTrue();
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  _isLoading = false;
                  myComponents.loadConfirmed(context, (){Navigator.pop(context);}, "LOADING CONFIRMED", "Cash In", loadAmount);
                  //myComponents.error(context, "ERROR!", "Hello, ${username}! You only have a Top Up limit of ${limit}. Please reenter a valid amount to proceed.");
                  //myComponents.error(context, "ERROR!", "No connection. Please check your internet connectivity and try again.");
                  //myComponents.error(context, "ERROR!", "Please try again later.");
                });
              });
            });
          }, 
          "${loadAmount}",);
        });
    });
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  pageComponents myComponents = pageComponents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      drawer:  NavDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: myComponents.background(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [ 
                  SizedBox(height: 60.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Center(
                      child: Text(
                        "Choose denomination to generate QR code.",
                        style: TextStyle(
                          color: Color(0xff18467e),
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadAmount = 10;
                      loadingConnect();
                    },
                    text: "10",
                    BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                    padding:  EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadAmount = 50;
                      loadingConnect();
                    },
                    text: "50",
                    BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                    padding:  EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadAmount = 100;
                      loadingConnect();
                    },
                    text: "100",
                    BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                    padding:  EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadAmount = 250;
                      loadingConnect();
                    },
                    text: "250",
                    BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                    padding:  EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadAmount = 500;
                      loadingConnect();
                    },
                    text: "500",
                    BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                    padding:  EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      loadingEnter();
                    },
                    text: "Enter Amount",
                    BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                    padding:  EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    BorderRadius: BorderRadius.circular(8.0),
                  ),
                ]
              ),
            ),
            myComponents.headerPageLabel(context, ""),
            Center(
              child: _isLoading ? myComponents.simulateLoading(context: context, loadText: "Processing") : Text(''),
            ),
          ]
        )
      )
    );
  }
}