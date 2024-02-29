import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/components.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'mainPage.dart';
import 'accountSetup.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  pageComponents myComponents = pageComponents();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String headerText = 'CREATE PIN';
  String buttonText = 'CREATE'; // Initial text for the button
  bool hasError = false;
  String currentText = "";
  bool _isLoading = false;

  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  void create() {
    setState(() {
      headerText = "CONFIRM PIN";
      buttonText = 'CONFIRM';
    });
  }

  void confirm() {
    setState(() {
      headerText = "CONFIRM PIN";
      buttonText = 'CONFIRM';
    });
  }

  void enter() {
    setState(() {
      headerText = "ENTER PIN";
      buttonText = 'ENTER';
    });
  }

  void loadingCreate() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        create();
      });
    });
  }

  void loadingConfirm() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        enter();
      });
    });
  }

  void loadingEnter() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountSetup()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width*1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: myComponents.background()
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        headerText,
                        style: TextStyle(
                          color: Color.fromRGBO(39, 50, 115, 1.0),
                          fontWeight: FontWeight.w900,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "To protect the security of your account, please register a 4-Digit PIN Code.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(39, 50, 115, 1.0),
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: PinCodeTextField(
                            pastedTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                            appContext: context,
                            controller: controller,
                            length: 4,
                            obscureText: true,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            cursorHeight: 19,
                            enableActiveFill: true,
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              fieldWidth: 50,
                              inactiveColor: Color.fromRGBO(224, 224, 224, 1.0),
                              selectedColor: Color.fromRGBO(0, 174, 237, 1.0),
                              activeFillColor: Color.fromRGBO(0, 174, 237, 1.0),
                              selectedFillColor: Color.fromRGBO(0, 174, 237, 1.0),
                              inactiveFillColor: Color.fromRGBO(224, 224, 224, 1.0),
                              activeColor: Color.fromRGBO(0, 174, 237, 1.0),
                            ),
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                            animationDuration: const Duration(milliseconds: 300),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          hasError ? "Please fill up all the cells properly" : "",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 200),
                      mainButtons.mainButton(
                        context: context,
                        onPressed: () {
                          formKey.currentState!.validate();
                          if (currentText.length != 4) {
                            errorController!.add(ErrorAnimationType
                                .shake);
                            setState(() {
                              hasError = true;
                            });
                          } else if(currentText.length == 4 && buttonText == 'CREATE'){
                            setState(
                              () {
                                hasError = false;
                                loadingCreate();
                              },
                            );
                          } else if(currentText.length == 4 && buttonText == 'CONFIRM'){
                            setState(
                              () {
                                hasError = false;
                                loadingConfirm();
                              },
                            );
                          } else if(currentText.length == 4 && buttonText == 'ENTER'){
                            setState(
                              () {
                                hasError = false;
                                loadingEnter();
                                
                              },
                            );
                          }
                        },
                        text: buttonText,
                        BackgroundColor:  Color.fromRGBO(82, 161, 217, 1.0),
                        padding:  EdgeInsets.symmetric(horizontal: 130.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(8.0),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: _isLoading ? myComponents.simulateLoading(context: context, loadText: "Processing") : Text(''),
              ),
            ],
          ),
        ),
      )
    );
  }
}