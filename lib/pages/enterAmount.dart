import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'drawer.dart';
import 'eWallet.dart';
import 'dart:async';

class EnterAmountPage extends StatefulWidget {
  const EnterAmountPage({Key? key}) : super(key: key);

  @override
  State<EnterAmountPage> createState() => _EnterAmountPageState();
}

class _EnterAmountPageState extends State<EnterAmountPage> {
  double loadAmount = 0.0;
  bool _isLoading = false;
  final FocusNode _focusNode = FocusNode();

  void setTrue() {
    setState(() {
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
            setTrue();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _isLoading = false;
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

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  pageComponents myComponents = pageComponents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      drawer: NavDrawer(),
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: AmountField(
                          focusNode: _focusNode,
                          onAmountChanged: (amount) {
                            setState(() {
                              loadAmount = amount;
                            });
                          },
                        ),
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
                          BackgroundColor: Color.fromRGBO(47, 50, 145, 1.0),
                          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                          BorderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: _isLoading ? myComponents.simulateLoading(context: context, loadText: "Processing") : Text(''),
            ),
          ],
        ),
      ),
    );
  }
}

class AmountField extends StatefulWidget {
  final FocusNode focusNode;
  final Function(double) onAmountChanged;

  const AmountField({
    Key? key,
    required this.focusNode,
    required this.onAmountChanged,
  }) : super(key: key);

  @override
  _AmountFieldState createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: _controller,
      onChanged: (value) {
        widget.onAmountChanged(double.tryParse(value) ?? 0.0);
      },
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
          borderSide: BorderSide(color: Color(0xff53a1d8), width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xff53a1d8), width: 3),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
