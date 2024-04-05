import 'dart:math';

import 'package:filipay_beta/functions/httpRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import '../widgets/components.dart';
import 'enterAmount.dart';
import 'eWallet.dart';
import '../functions/functions.dart';
import 'drawer.dart';

class SelectAmountPage extends StatefulWidget {
  const SelectAmountPage({super.key});

  @override
  State<SelectAmountPage> createState() => _SelectAmountPageState();
}

class _SelectAmountPageState extends State<SelectAmountPage> {
  // final Box _filipay = Hive.box('filipay');
  pageFunctions myFunc = pageFunctions();
  httprequestService httpService = httprequestService();

  double balance = 0.0;

  bool _isLoading = false;
  String username = "[name]";
  double limit = 10000;
  final FocusNode _focusNode = FocusNode();

  void loadingEnter(double amount) {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EnterAmountPage()));
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeWallet();
  }

  void _initializeWallet() async {
    Map<String, dynamic> getWalletResponse = await httpService.getWallet();
    balance = getWalletResponse['response']['balance'].toDouble();
    // setState(() {
    //   myFunc.remaining_balance = balance;
    //   Logger().i(myFunc.remaining_balance);
    // });
    // Logger().i(getWalletResponse);
  }

  void updateBalance(double amount) {
    setState(() {
      balance += amount;
      String referenceCode = "FP${Random().nextInt(999999).toString().padLeft(6, '0')}";
      () async {
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
            _isLoading = false;
          });
        } else {
          Navigator.of(context).pop();
          myComponents.errorModal(context, "${isUpdateResponse['messages']['message']}");
        }
      };
      // Logger().i(Wallet);
    });
  }

  void setTrue() {
    setState(() {
      _isLoading = true;
    });
  }

  void loadingConnect(double loadAmount) {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        myComponents.slider(
          context,
          () {
            Navigator.pop(context);
            setTrue();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _isLoading = false;
                updateBalance(loadAmount);
                myComponents.loadConfirmed(context, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EWalletPage()),
                  );
                }, "LOADING CONFIRMED", "Cash In", loadAmount);
              });
            });
          },
          loadAmount,
        );
      });
    });
  }

  void confirmTopUp() {
    _focusNode.unfocus();
    if (_formKey.currentState!.validate()) {
      setTrue();
      // Call loadingConnect only when confirm button is pressed
      loadingConnect(double.parse(_controller.text));
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  pageComponents myComponents = pageComponents();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> buttonData = [
      {
        'text': '10',
        'onPressed': () {
          double loadAmount = 10;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '20',
        'onPressed': () {
          double loadAmount = 20;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '30',
        'onPressed': () {
          double loadAmount = 30;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '40',
        'onPressed': () {
          double loadAmount = 40;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '50',
        'onPressed': () {
          double loadAmount = 50;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '100',
        'onPressed': () {
          double loadAmount = 100;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '250',
        'onPressed': () {
          double loadAmount = 250;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '500',
        'onPressed': () {
          double loadAmount = 500;
          _controller.text = "${loadAmount}";
        },
      },
      {
        'text': '1000',
        'onPressed': () {
          double loadAmount = 1000;
          _controller.text = "${loadAmount}";
        },
      },
    ];
    return Scaffold(
        key: scaffoldKey,
        appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
        drawer: NavDrawer(),
        body: SafeArea(
            child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: myComponents.background(),
          ),
          SingleChildScrollView(
            child: Column(children: [
              myComponents.headerPageLabel(context, ""),
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
              SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Enter desired load amount",
                    ),
                    AmountField(
                      focusNode: _focusNode,
                      controller: _controller,
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Or you can also choose from the amount selection below?",
                    ),
                    SizedBox(height: 10.0),
                    GridView.builder(
                      shrinkWrap: true, // Add this line
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 1.5, // Aspect ratio of each grid item
                      ),
                      itemCount: buttonData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return mainButtons.loadButtons(
                          context: context,
                          onPressed: () {
                            buttonData[index]['onPressed']();
                          },
                          text: buttonData[index]['text'],
                          BackgroundColor: Colors.white,
                          textColor: Color(0xff53a1d8),
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          radius: BorderRadius.circular(8.0),
                        );
                      },
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: mainButtons.mainButton(
                        context: context,
                        onPressed: confirmTopUp,
                        text: 'CONFIRM',
                        BackgroundColor: Color.fromRGBO(47, 50, 145, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ]),
                ),
              ),
            ]),
          ),
          Center(
            child: _isLoading ? myComponents.simulateLoading(context: context, loadText: "Processing") : Text(''),
          ),
        ])));
  }
}

class AmountField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  const AmountField({
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
