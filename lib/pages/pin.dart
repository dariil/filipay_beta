import 'dart:async';
import 'package:filipay_beta/functions/httpRequest.dart';
import 'package:filipay_beta/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import '../widgets/components.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../functions/functions.dart';
import 'accountSetup.dart';
import '../functions/myEncryption.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  httprequestService httpService = httprequestService();
  pageComponents myComponents = pageComponents();
  pageFunctions pinPage = pageFunctions();

  StreamController<ErrorAnimationType>? errorController;
  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String headerText = 'CREATE PIN';
  String buttonText = 'CREATE';
  String headerText_change = 'CONFIRM PIN';
  String buttonText_change = 'CONFIRM';
  String loginHeaderText = "ENTER PIN";
  String loginButtonText = "ENTER";
  bool hasError = false;
  bool _isLoading = false;
  var currentText;
  var newPin;
  var confirmPin;
  var pinEnter;
  var userPin;

  final _filipay = Hive.box("filipay");

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
      pinController.text = "";
    });
  }

  void confirm() {
    setState(() {
      headerText = "CONFIRM PIN";
      buttonText = 'CONFIRM';
      pinController.text = "";
    });
  }

  void enter() {
    setState(() {
      headerText = "ENTER PIN";
      buttonText = 'ENTER';
      pinController.text = "";
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
    Future.delayed(Duration(seconds: 2), () async {
      setState(() {
        var ecryptedText = MyEncryptionDecryption.encryptAES(confirmPin).toString();
        userPin = ecryptedText;
        _isLoading = false;
      });
      Logger().i(userPin);
      Map<String, dynamic> isUpdateResponse = await httpService.UpdateUser({
        "pin": userPin.toString(),
      });
      if (isUpdateResponse['messages']['code'].toString() == '0') {
        pinPage.pinMode = false;
        pinPage.loginPin = false;
        pinPage.current_user_id = isUpdateResponse['response']['_id'].toString();
        Logger().i(pinPage.current_user_id);

        _filipay.put('tbl_users_mndb', isUpdateResponse);
      } else {
        myComponents.errorModal(context, "${isUpdateResponse['messages']['message']}");
      }
      setState(() {
        enter();
      });
    });
  }

  void pinChanged() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      final userList = _filipay.get('tbl_users');
      setState(() {
        _isLoading = false;
        int index = userList.indexWhere((user) => user['user_id'] == pinPage.current_user_id);
        var encryptPin = MyEncryptionDecryption.encryptAES(confirmPin).toString();
        userList[index]['user_pin'] = encryptPin;
        print(pinPage.current_user_id);
        userPin = userList[index]['user_pin'].toString();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountSetup()),
        );
      });
      _filipay.put('tbl_users', pinPage.tbl_users);
    });
  }

  void loadingEnter() {
    _isLoading = true;
    Logger().i(pinPage.current_user_id);
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

  void loginEnter() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      });
    });
  }

  void enterNew() {
    headerText_change = "ENTER NEW PIN";
    buttonText_change = 'ENTER';
    pinController.text = "";
  }

  void loadingEnterNew() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        enterNew();
      });
    });
  }

  void pinMismatch() {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          myComponents.error(context, "PIN Mismatched!", "The current pin mismatched the pin that you have entered before. Please try again.");
        });
      });
    });
  }

  void incorrectPin() {
    print(pinPage.current_user_id);
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          myComponents.error(context, "MALI BOBO!", "The pin that you have entered is incorrect. Please try again.");
        });
      });
    });
  }

  Future<void> _pinLogin() async {
    _isLoading = true;
    final tbl_users_mndb = _filipay.get('tbl_users_mndb');
    var decryptPin = MyEncryptionDecryption.decryptAES(tbl_users_mndb['response']['pin']).toString();
    Future.delayed(Duration(seconds: 2), () {
      if (pinEnter.toString() != decryptPin) {
        _isLoading = false;
        setState(() {
          incorrectPin();
        });
      } else {
        setState(() {
          // Logger().i(pinPage.current_user_id);
          _isLoading = false;
          pinPage.loginPin = false;
          if (tbl_users_mndb['response'].containsKey('firstName')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountSetup()),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          children: [
            Align(alignment: Alignment.bottomCenter, child: myComponents.background()),
            if (pinPage.pinMode)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        headerText_change,
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
                            controller: pinController,
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
                            errorController!.add(ErrorAnimationType.shake);
                            setState(() {
                              hasError = true;
                            });
                          } else if (currentText.length == 4 && buttonText_change == 'CONFIRM') {
                            setState(
                              () {
                                hasError = false;
                                newPin = currentText.toString();
                                loadingEnterNew();
                              },
                            );
                          } else if (currentText.length == 4 && buttonText_change == 'ENTER') {
                            confirmPin = currentText.toString();
                            if (confirmPin != newPin) {
                              pinMismatch();
                            } else {
                              setState(
                                () {
                                  hasError = false;
                                  pinChanged();
                                  pinPage.pinMode = false;
                                },
                              );
                            }
                          }
                        },
                        text: buttonText_change,
                        BackgroundColor: Color.fromRGBO(82, 161, 217, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(8.0),
                      ),
                    ],
                  ),
                ),
              )
            else if (pinPage.loginPin)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loginHeaderText,
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
                        "Please enter your 4-Digit PIN Code.",
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
                            controller: pinController,
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
                            errorController!.add(ErrorAnimationType.shake);
                            setState(() {
                              hasError = true;
                            });
                          } else if (currentText.length == 4 && loginButtonText == 'ENTER') {
                            setState(
                              () {
                                hasError = false;
                                pinEnter = currentText.toString();

                                _pinLogin();
                              },
                            );
                          }
                        },
                        text: loginButtonText,
                        BackgroundColor: Color.fromRGBO(82, 161, 217, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(8.0),
                      ),
                    ],
                  ),
                ),
              )
            else
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
                            controller: pinController,
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
                            errorController!.add(ErrorAnimationType.shake);
                            setState(() {
                              hasError = true;
                            });
                          } else if (currentText.length == 4 && buttonText == 'CREATE') {
                            setState(
                              () {
                                hasError = false;
                                loadingCreate();
                                newPin = currentText.toString();
                              },
                            );
                          } else if (currentText.length == 4 && buttonText == 'CONFIRM') {
                            confirmPin = currentText.toString();
                            if (confirmPin != newPin) {
                              pinMismatch();
                            } else {
                              setState(
                                () {
                                  hasError = false;
                                  loadingConfirm();
                                },
                              );
                            }
                          } else if (currentText.length == 4 && buttonText == 'ENTER') {
                            pinEnter = currentText;
                            var decryptedPin = MyEncryptionDecryption.decryptAES(userPin).toString();
                            if (pinEnter.toString() != decryptedPin.toString()) {
                              incorrectPin();
                            } else {
                              setState(
                                () {
                                  hasError = false;
                                  loadingEnter();
                                },
                              );
                            }
                          }
                        },
                        text: buttonText,
                        BackgroundColor: Color.fromRGBO(82, 161, 217, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 20.0),
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
    ));
  }
}
