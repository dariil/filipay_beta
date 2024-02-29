import 'dart:ffi';

import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'drawer.dart';

import 'dart:async';

class EnterAmountPage extends StatefulWidget {
  const EnterAmountPage({super.key});

  @override
  State<EnterAmountPage> createState() => _EnterAmountPageState();
}

class _EnterAmountPageState extends State<EnterAmountPage> {
  double loadAmount = 500.00;
  bool _isLoading = false;
  String username = "[name]";
  double limit = 10000;
  final FocusNode _focusNode = FocusNode();

  void setTrue(){
    setState((){
      _isLoading = true;
    });
  }

  void loadingConnect() {
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
                  myComponents.loadConfirmed(context, (){Navigator.pop(context); Navigator.pop(context);}, "LOADING CONFIRMED", "Cash In", loadAmount);
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            myComponents.headerPageLabel(context, ""),
            Align(
              alignment: Alignment.bottomCenter,
              child: myComponents.background(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Center(
                    child: Text(
                      "Enter Amount",
                      style: TextStyle(
                        color: Color(0xff18467e),
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: AmountField(focusNode:  _focusNode),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: mainButtons.mainButton(
                          context: context,
                          onPressed: () {
                            _focusNode.unfocus();
                            if (_formKey.currentState!.validate()) {
                              setTrue();
                              loadingConnect();
                            }
                          },
                          text: 'CONFIRM',
                          BackgroundColor:  Color.fromRGBO(47, 50, 145, 1.0),
                          padding:  EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                          BorderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
            Center(
              child: _isLoading ? myComponents.simulateLoading(context: context, loadText: "Processing") : Text(''),
            ),
            // Center(
            //   child: showSlider ? myComponents.slider(context: context, loadText: "TESTING") : Text(''),
            // ),
          ]
        )
      )
    );
  }
}

class AmountField extends StatelessWidget {
  final FocusNode focusNode;

  const AmountField({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid amount';
        }
        return null;
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Color(0xff53a1d8), width: 3),
        ),
        enabledBorder: OutlineInputBorder( // Border style when the field is enabled
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Color(0xff53a1d8), width: 3),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:  EdgeInsets.symmetric(horizontal: 10),
      ),
      keyboardType: TextInputType.number,
    );
  }
}