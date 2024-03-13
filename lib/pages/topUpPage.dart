import 'package:filipay_beta/pages/selectAmount.dart';
import 'package:flutter/cupertino.dart';
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
  Icon myIcon = Icon(Icons.add_circle_outline_sharp, color: Color(0xff18467e));

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

  void setTrue() {
    setState(() {
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
        }, "Successful!", "Your total balance is 100 FILIPAY Credits.");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: myComponents.background(),
      ),
      SingleChildScrollView(
        child: Column(children: [
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
          if (isConnected)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myIcon,
                SizedBox(
                  width: 20.0,
                ),
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
            )
          else
            Row(
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
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              color: Colors.grey,
              thickness: 5.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                topupbutton(
                  label: "via ONLINE",
                  imagename: "site-alt.png",
                  thisFunction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectAmountPage()));
                  },
                ),
                topupbutton(
                  label: "via FILIPAY\nDistributor",
                  imagename: "store-alt-solid.png",
                  thisFunction: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SelectAmountPage()));
                  },
                ),
                topupbutton(
                  label: "via Driver",
                  imagename: "driver-man.png",
                  thisFunction: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SelectAmountPage()));
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
      Center(
        child: _isLoading
            ? myComponents.simulateConnectLoading(
                context: context, loadText: "Please wait...")
            : Text(''),
      ),
      myComponents.headerPageLabel(context, ""),
    ])));
  }
}

class topupbutton extends StatelessWidget {
  const topupbutton(
      {super.key,
      required this.label,
      required this.imagename,
      required this.thisFunction});
  final String label;
  final String imagename;
  final void Function() thisFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: thisFunction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectAmountPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffb5e1ee),
                          border: Border.all(
                            width: 4.0,
                            color: Color(0xff61a7da),
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Image(
                          image: AssetImage("assets/e-wallet/$imagename"),
                          width: 80.0,
                          height: 80.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                "$label",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
