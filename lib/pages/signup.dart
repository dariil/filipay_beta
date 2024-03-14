import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';
import 'login.dart';
import 'pin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;

  pageComponents myComponents = pageComponents();
  pageFunctions myFunc = pageFunctions();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  final _filipay = Hive.box("filipay");

  // List<Map<String, dynamic>> tbl_users = [];

  Future<void> _initializedData() async {
    _filipay.put('tbl_users', myFunc.tbl_users);
    _filipay.put('tbl_user_profile', myFunc.tbl_user_profile);

    final userList = _filipay.get('tbl_users');
    final userProfileList = _filipay.get('tbl_user_profile');

    myFunc.user_id = myFunc.tbl_users.length;
    myFunc.current_user_id = myFunc.user_id;

    userList.add({
      "user_id": myFunc.user_id,
      "user_email": emailControler.text,
      "user_pass": passController.text,
      "user_pin": 0000,
    });

    myFunc.user_profile_id = myFunc.tbl_user_profile.length;

    userProfileList.add({
      "user_profile_id": myFunc.user_profile_id,
      "user_id": myFunc.current_user_id,
      "profile_picture": "",
      "firstname": "",
      "middlename": "",
      "lastname": "",
      "date_of_birth": "",
      "address": "",
      "user_type": "N/A",
      "cash_limits": 0.0,
    });

    print(userList[0]['user_email']);
    print("TESTING!");
    _filipay.put('tbl_users', myFunc.tbl_users);
    _filipay.put('tbl_user_profile', myFunc.tbl_user_profile);
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: myComponents.background(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 54.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage(
                            "assets/general/filipay-logo-w-name.png"),
                        width: 115,
                        height: 115,
                      ),
                      Center(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(39, 50, 115, 1.0),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(195, 224, 232, 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email Address",
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 80, 120, 1.0),
                                      ),
                                    ),
                                    TextFormFieldsWidget(
                                      thisTextInputType:
                                          TextInputType.emailAddress,
                                      emailController: emailControler,
                                    ),
                                    Text(
                                      "Create Password",
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 80, 120, 1.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: PasswordFormFieldWidget(
                                        thisTextInputType:
                                            TextInputType.visiblePassword,
                                        controller: passController,
                                        confirmPasswordController:
                                            confirmPassController,
                                      ),
                                    ),
                                    Text(
                                      "Confirm Password",
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 80, 120, 1.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: PasswordFormFieldWidget(
                                        thisTextInputType:
                                            TextInputType.visiblePassword,
                                        controller: confirmPassController,
                                        confirmPasswordController:
                                            passController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: mainButtons.mainButton(
                                      context: context,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _initializedData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreatePin()),
                                          );
                                        }

                                        if (passController.text !=
                                            confirmPassController.text) {}
                                      },
                                      text: 'SIGN UP',
                                      BackgroundColor:
                                          Color.fromRGBO(47, 50, 145, 1.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      BorderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5.2),
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: 1.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Text("OR",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 18.0,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an account?",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              },
                              child: Text(
                                "Login here",
                                style: TextStyle(
                                  color: Color.fromRGBO(189, 223, 241, 1),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFormFieldWidget extends StatefulWidget {
  PasswordFormFieldWidget({
    super.key,
    required this.thisTextInputType,
    required this.controller,
    required this.confirmPasswordController,
  });
  final TextInputType thisTextInputType;
  final TextEditingController controller;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordFormFieldWidget> createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  bool _obscureText = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    }
    if (value != widget.controller.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.thisTextInputType,
      obscureText: _obscureText,
      controller: widget.confirmPasswordController,
      validator: _validatePassword,
      decoration: InputDecorations.passwordFields(
        obscureText: _obscureText,
        togglePassword: _togglePassword,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class TextFormFieldsWidget extends StatelessWidget {
  TextFormFieldsWidget(
      {super.key,
      required this.thisTextInputType,
      required this.emailController});
  final TextInputType thisTextInputType;
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: emailController,
        keyboardType: thisTextInputType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter an email address';
          }
          // Regular expression for email validation
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        decoration: myComponents.textFieldWhite(
          BorderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
