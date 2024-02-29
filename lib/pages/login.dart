
import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'signup.dart';
import 'mainPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
        child: Stack(
          children:[ 
            myComponents.background(),
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
                       SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding:  EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color:  Color.fromRGBO(195, 224, 232, 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Center(
                                      child: Text(
                                        "Transport User Details",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color.fromRGBO(5, 80, 120, 1.0),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0
                                    ),
                                    Text(
                                      "Your Email",
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 80, 120, 1.0),
                                      ),
                                    ),
                                    TextFormFieldsWidget(thisTextInputType: TextInputType.emailAddress,),
                                    GestureDetector(
                                      onTap: () {
                                        print('Text tapped!');
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child:  Text(
                                          "Use Mobile Number Instead",
                                          style: TextStyle(
                                            color: Color.fromRGBO(5, 80, 120, 1.0),
                                            fontSize: 10.0,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                     Text(
                                      "Enter Password",
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 80, 120, 1.0),
                                      ),
                                    ),
                                     SizedBox(
                                      width: double.infinity,
                                      
                                      child: PasswordFormFieldWidget(thisTextInputType: TextInputType.visiblePassword,),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Pass text tapped!');
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child:  Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: Color.fromRGBO(5, 80, 120, 1.0),
                                            fontSize: 10.0,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text(
                                    "don't have an account?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (
                                    ) {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>  RegisterPage(),
                                      ));
                                    },
                                    child:  Text("Register here",
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 80, 120, 1.0),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 80.0, vertical: 8.0),
                                  child: SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: mainButtons.mainButton(
                                      context: context,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  MainPage()),
                                          );
                                        }
                                      },
                                      text: 'LOGIN',
                                      BackgroundColor:  Color.fromRGBO(47, 50, 145, 1.0),
                                      padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      BorderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                               SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.8,
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
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                        child: myComponents.otherSignupBtn(context: context, imagePath: "assets/general/facebook-logo.png", buttonText: "Sign in with Facebook", buttonColor:  Color.fromRGBO(11, 97, 184, 1.0),  buttonTextColor: Colors.white),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                        child: myComponents.otherSignupBtn(context: context, imagePath: "assets/general/google-icon.png", buttonText: "Sign in with Google", buttonColor: Colors.white,  buttonTextColor: Colors.black),
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
        borderRadius: BorderRadius.circular(20.0),
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
        decoration: myComponents.textFieldWhite(BorderRadius: BorderRadius.circular(20.0),),
      ),
    );
  }
}