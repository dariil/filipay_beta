import 'package:filipay_beta/pages/selectAmount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/components.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  pageComponents myComponents = pageComponents();

  String cardNumber = "SN XXXXXXXXX";
  bool isConnected = false;
  Icon myIcon = Icon(
    Icons.add_circle_outline_sharp, 
    color: Color(0xff18467e)
  );

  bool _isLoading = false;

  void connected() {
    setState(() {
      isConnected = true;
      myIcon = Icon(
        Icons.credit_card_rounded, 
        color: Color(0xff00adee),
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
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        connected();
        myComponents.alert(context, () {
          Navigator.of(context).pop();
        }, 
        "Successful!",
        "Your total balance is 100 FILIPAY Credits.");
        });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(height: 70.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Center(
                      child: Text(
                        "How would you like to top up?",
                        style: TextStyle(
                          color: Color(0xff18467e),
                          fontSize: 35.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                        SizedBox(height: 15.0),
                        if (isConnected) Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              myIcon,
                              SizedBox(width: 20.0,),
                              Text.rich(
                                TextSpan(
                                  text: 'Card Connected\n',
                                  style: TextStyle(
                                    color: Color(0xff00adee),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: cardNumber,
                                      style: TextStyle(
                                        color: Color(0xff00adee),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ) else Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              myIcon,
                              Container(
                                width: 260.0,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'Connect FILIPAY Card',
                                    hintStyle: TextStyle(fontSize: 20.0),
                                    border: InputBorder.none, 
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    // Handle the saved value
                                  },
                                  onFieldSubmitted: (value) {
                                    loadingConnect();
                                  },
                                ),
                              ),
                            ],
                          ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Divider(
                            color: Colors.grey,
                            thickness: 5.0,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.0),
                            myComponents.topUpMode(padding: 10.0, context: context, page:  SelectAmountPage(), modeText: "", path: "assets/e-wallet/Store_Icon.png"),
                            SizedBox(width: 25.0),
                            Expanded(
                              child: Text(
                                "via FILIPAY Distributor",
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.0),
                            myComponents.topUpMode(padding: 10.0, context: context, page:  SelectAmountPage(), modeText: "", path: "assets/e-wallet/Driver_Icon.png"),
                            SizedBox(width: 25.0),
                            Expanded(
                              child: Text(
                                "via Driver",
                                style: TextStyle(
                                    fontSize: 30.0,
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
            ),
                  Center(
                    child: _isLoading ? myComponents.simulateConnectLoading(context: context, loadText: "Please wait...") : Text(''),
                  ),
                  myComponents.headerPageLabel(context, ""),
                ]
              )
            )
        );
  }
}