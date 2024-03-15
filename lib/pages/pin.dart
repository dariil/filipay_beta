import 'dart:async';
import 'package:filipay_beta/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/components.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../functions/functions.dart';
import 'accountSetup.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
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
  String currentText = "";
  int? newPin;
  int? confirmPin;
  int? pinEnter;
  int? userPin;

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

  Future<void> currentUserPin() async {
    print("\n\nTHIS IS WORKING\n\n");
    // _filipay.put('tbl_users', pinPage.tbl_users);
    final userList = _filipay.get('tbl_users');
    int index = userList
        .indexWhere((user) => user['user_id'] == pinPage.current_user_id);
    userPin = userList[index]['user_pin'];
  }

  /////////////////////////////////////////////////////////////////////////////////////////////
  void loadingConfirm() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      // _filipay.put('tbl_users', pinPage.tbl_users);
      final userList = _filipay.get('tbl_users');
      setState(() {
        _isLoading = false;
        int index = userList
            .indexWhere((user) => user['user_id'] == pinPage.current_user_id);
        userList[index]['user_pin'] = confirmPin;
        print(pinPage.current_user_id);
        userPin = userList[index]['user_pin'];
        print(userList[index]['user_pin']);
        enter();
        _filipay.put('tbl_users', pinPage.tbl_users);
      });
    });
  }

  void pinChanged() {
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      // _filipay.put('tbl_users', pinPage.tbl_users);
      final userList = _filipay.get('tbl_users');
      setState(() {
        _isLoading = false;
        int index = userList
            .indexWhere((user) => user['user_id'] == pinPage.current_user_id);
        userList[index]['user_pin'] = confirmPin;
        print(pinPage.current_user_id);
        userPin = userList[index]['user_pin'];
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
          myComponents.error(context, "PIN Mismatched!",
              "The current pin mismatched the pin that you have entered before. Please try again.");
        });
      });
    });
  }

  void incorrectPin() {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          myComponents.error(context, "Incorrect Pin!",
              "The pin that you have entered is incorrect. Please try again.");
        });
      });
    });
  }

  Future<void> _pinLogin() async {
    // _filipay.put('tbl_users', pinPage.tbl_users);
    // _filipay.put('tbl_user_profile', pinPage.tbl_user_profile);
    final userList = _filipay.get('tbl_users');
    final userProfileList = _filipay.get('tbl_user_profile');

    int userProfileListIndex = userProfileList
        .indexWhere((user) => user['user_id'] == pinPage.current_user_id);
    int index = userList
        .indexWhere((user) => user['user_id'] == pinPage.current_user_id);
    userPin = userList[index]['user_pin'];
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      if (pinEnter != userPin) {
        _isLoading = false;
        setState(() {
          incorrectPin();
        });
      } else {
        if (userProfileList[userProfileListIndex]['firstname'] == "" ||
            userProfileList[userProfileListIndex]['middlename'] == "" ||
            userProfileList[userProfileListIndex]['lastname'] == "" ||
            userProfileList[userProfileListIndex]['date_of_birth'] == "" ||
            userProfileList[userProfileListIndex]['address'] == "" ||
            userProfileList[userProfileListIndex]['user_type'] == "N/A") {
          setState(() {
            _isLoading = false;
            pinPage.loginPin = false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountSetup()),
            );
          });
        } else {
          setState(() {
            _isLoading = false;
            pinPage.loginPin = false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          });
        }
      }
    });
  }

  // Future<bool> _pinLogin(String email, String password) async {
  //   final userList = _filipay.get('tbl_users');

  //   for (var user in userList) {
  //     if (user['user_email'] == email && user['user_pass'] == password) {
  //       print('Login successful for ${user['user_email']}');
  //       return true;
  //     }
  //   }
  //   print('Login failed');
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: myComponents.background()),
            if (pinPage.pinMode)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              fieldWidth: 50,
                              inactiveColor: Color.fromRGBO(224, 224, 224, 1.0),
                              selectedColor: Color.fromRGBO(0, 174, 237, 1.0),
                              activeFillColor: Color.fromRGBO(0, 174, 237, 1.0),
                              selectedFillColor:
                                  Color.fromRGBO(0, 174, 237, 1.0),
                              inactiveFillColor:
                                  Color.fromRGBO(224, 224, 224, 1.0),
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          hasError
                              ? "Please fill up all the cells properly"
                              : "",
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
                          } else if (currentText.length == 4 &&
                              buttonText_change == 'CONFIRM') {
                            setState(
                              () {
                                hasError = false;
                                newPin = int.parse(currentText);
                                loadingEnterNew();
                              },
                            );
                          } else if (currentText.length == 4 &&
                              buttonText_change == 'ENTER') {
                            confirmPin = int.parse(currentText);
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 130.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(8.0),
                      ),
                    ],
                  ),
                ),
              )
            else if (pinPage.loginPin)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              fieldWidth: 50,
                              inactiveColor: Color.fromRGBO(224, 224, 224, 1.0),
                              selectedColor: Color.fromRGBO(0, 174, 237, 1.0),
                              activeFillColor: Color.fromRGBO(0, 174, 237, 1.0),
                              selectedFillColor:
                                  Color.fromRGBO(0, 174, 237, 1.0),
                              inactiveFillColor:
                                  Color.fromRGBO(224, 224, 224, 1.0),
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          hasError
                              ? "Please fill up all the cells properly"
                              : "",
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
                          } else if (currentText.length == 4 &&
                              loginButtonText == 'ENTER') {
                            setState(
                              () {
                                hasError = false;
                                pinEnter = int.parse(currentText);
                                // loginEnter();
                                _pinLogin();
                              },
                            );
                          }
                        },
                        text: loginButtonText,
                        BackgroundColor: Color.fromRGBO(82, 161, 217, 1.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 130.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(8.0),
                      ),
                    ],
                  ),
                ),
              )
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              fieldWidth: 50,
                              inactiveColor: Color.fromRGBO(224, 224, 224, 1.0),
                              selectedColor: Color.fromRGBO(0, 174, 237, 1.0),
                              activeFillColor: Color.fromRGBO(0, 174, 237, 1.0),
                              selectedFillColor:
                                  Color.fromRGBO(0, 174, 237, 1.0),
                              inactiveFillColor:
                                  Color.fromRGBO(224, 224, 224, 1.0),
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          hasError
                              ? "Please fill up all the cells properly"
                              : "",
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
                          } else if (currentText.length == 4 &&
                              buttonText == 'CREATE') {
                            setState(
                              () {
                                hasError = false;
                                loadingCreate();
                                newPin = int.parse(currentText);
                              },
                            );
                          } else if (currentText.length == 4 &&
                              buttonText == 'CONFIRM') {
                            confirmPin = int.parse(currentText);
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
                          } else if (currentText.length == 4 &&
                              buttonText == 'ENTER') {
                            pinEnter = int.parse(currentText);
                            currentUserPin();
                            if (pinEnter != userPin) {
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 130.0, vertical: 20.0),
                        BorderRadius: BorderRadius.circular(8.0),
                      ),
                    ],
                  ),
                ),
              ),
            Center(
              child: _isLoading
                  ? myComponents.simulateLoading(
                      context: context, loadText: "Processing")
                  : Text(''),
            ),
          ],
        ),
      ),
    ));
  }
}
