import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'login.dart';
import 'pin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  pageComponents myComponents = pageComponents();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children:[ 
             Align(
              alignment: Alignment.bottomCenter,
              child: myComponents.background(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*1,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 54.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Image(
                        image: AssetImage("assets/general/filipay-logo-w-name.png"),
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
                                color:  Color.fromRGBO(195, 224, 232, 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email Address",
                                    style: TextStyle(
                                      color: Color.fromRGBO(5, 80, 120, 1.0),
                                    ),
                                  ),
                                  TextFormFieldsWidget(thisTextInputType: TextInputType.emailAddress,),
                                  Text(
                                    "Create Password",
                                    style: TextStyle(
                                      color: Color.fromRGBO(5, 80, 120, 1.0),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: PasswordFormFieldWidget(thisTextInputType: TextInputType.visiblePassword,),
                                  ),
                                  Text(
                                    "Confirm Password",
                                    style: TextStyle(
                                      color: Color.fromRGBO(5, 80, 120, 1.0),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: PasswordFormFieldWidget(thisTextInputType: TextInputType.visiblePassword,),
                                  ),
                                ],
                              ),
                            ),
                             SizedBox(
                              height: 25.0,
                            ),
                            Center(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: mainButtons.mainButton(
                                    context: context,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CreatePin()),
                                        );
                                      }
                                    },
                                    text: 'SIGN UP',
                                    BackgroundColor:  Color.fromRGBO(47, 50, 145, 1.0),
                                    padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                                      decoration:  BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:  Text(
                                        "OR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18.0,
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
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
                              onPressed: (
                              ) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  LoginPage(),
                                ));
                              },
                              child:  Text("Login here",
                                style: TextStyle(
                                  color: Color.fromRGBO(5, 80, 120, 1.0),
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
    super.key,required this.thisTextInputType
  });
  final TextInputType thisTextInputType;

  @override
  State<PasswordFormFieldWidget> createState() => _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  bool _obscureText = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.thisTextInputType,
      obscureText: _obscureText, 
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      decoration: InputDecorations.passwordFields(
        obscureText: _obscureText,
        togglePassword: _togglePassword,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}


class TextFormFieldsWidget extends StatelessWidget {
   TextFormFieldsWidget({
    super.key,required this.thisTextInputType
  });
  final TextInputType thisTextInputType;
  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: thisTextInputType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid email';
          }
          return null;
        },
        decoration: myComponents.textFieldWhite(BorderRadius: BorderRadius.circular(10.0),),
      ),
    );
  }
}