import 'dart:math';

import 'package:filipay_beta/functions/httpRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';

class qrPay extends StatefulWidget {
  const qrPay({super.key});

  @override
  State<qrPay> createState() => _qrPayState();
}

class _qrPayState extends State<qrPay> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  httprequestService httpService = httprequestService();
  pageFunctions myFunc = pageFunctions();
  pageComponents myComponents = pageComponents();
  bool isLoading = false;
  double balance = 0.0;

  void initState() {
    super.initState();

    _initializeWallet();
  }

  void _initializeWallet() async {
    Map<String, dynamic> getWalletResponse = await httpService.getWallet();
    balance = getWalletResponse['response']['balance'].toDouble();
  }

  void confirmPayment() {
    myComponents.bookConfirmation(
      context,
      () {
        setState(() {
          setTrue();
        });
        Navigator.pop(context);
        Future.delayed(Duration(seconds: 3), () {
          Logger().i(balance);
          Logger().i(double.parse(_controller.text));
          balance -= double.parse(_controller.text);
          String referenceCode = "FP${Random().nextInt(999999).toString().padLeft(6, '0')}";
          setState(() {
            isLoading = false;
            Future.delayed(Duration(seconds: 2), () async {
              Map<String, dynamic> isUpdateResponse = await httpService.Wallet({
                "userId": myFunc.current_user_id,
                "referenceCode": referenceCode,
                "balance": balance,
                "paymentMethod": "Online",
                "serviceFee": 5.00,
                "status": "SUCCESSFUL",
              });

              if (isUpdateResponse['messages']['code'].toString() == '0') {
                setState(() {
                  isLoading = false;
                });
              } else {
                Navigator.of(context).pop();
                myComponents.errorModal(context, "${isUpdateResponse['messages']['message']}");
              }
            });
          });
          myComponents.paymentSuccessful(context, double.parse(_controller.text));
          myFunc.remaining_balance = myFunc.remaining_balance - double.parse(_controller.text);
        });
      },
      () {
        Navigator.pop(context);
      },
      "Confirm Payment Amount",
      "Are you sure you want to confirm this payment?",
    );
  }

  void setTrue() {
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay to FILIPAY ${myFunc.transportMode}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(children: [
          myComponents.background(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Align(
                alignment: Alignment.topCenter,
                child: Image(
                  width: 150.0,
                  height: 150.0,
                  image: AssetImage("assets/general/filipay-logo.png"),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  "Enter Payment Amount:",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    PayableAmountField(
                      focusNode: _focusNode,
                      controller: _controller,
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: mainButtons.mainButton(
              context: context,
              onPressed: () {
                _focusNode.unfocus();
                if (_formKey.currentState!.validate()) {
                  confirmPayment();
                }
              },
              text: 'CONFIRM',
              BackgroundColor: Color.fromRGBO(47, 50, 145, 1.0),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              BorderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Center(
            child: isLoading ? myComponents.simulateLoading(context: context, loadText: "Please wait...") : Text(''),
          ),
        ]),
      ),
    );
  }
}

class PayableAmountField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  const PayableAmountField({
    Key? key,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid amount';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text(
          'PHP ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
