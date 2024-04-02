import 'package:filipay_beta/functions/httpRequest.dart';
import 'package:filipay_beta/pages/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';
import 'pin.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'changePasswordPage.dart';
import 'upgradeLimitsPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  httprequestService httpService = httprequestService();
  final _filipay = Hive.box("filipay");

  bool _isLoading = false;
  String selectedOption = "NONE";
  bool standardSelected = false;
  bool studentSelected = false;
  bool seniorSelected = false;
  bool pwdSelected = false;
  String? birthdate = "";
  File? _selectedImage;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  pageComponents myComponents = pageComponents();
  pageFunctions myFunc = pageFunctions();
  InputDecoration decoration = InputDecoration();
  TextEditingController controller = TextEditingController();
  bool isEditing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void standard() {
    setState(() {
      selectedOption = "STANDARD";
      standardSelected = true;
      studentSelected = false;
      seniorSelected = false;
      pwdSelected = false;
    });
  }

  void student() {
    setState(() {
      selectedOption = "STUDENT";
      standardSelected = false;
      studentSelected = true;
      seniorSelected = false;
      pwdSelected = false;
    });
  }

  void senior() {
    setState(() {
      selectedOption = "SENIOR CITIZEN";
      standardSelected = false;
      studentSelected = false;
      seniorSelected = true;
      pwdSelected = false;
    });
  }

  void pwd() {
    setState(() {
      selectedOption = "PWD";
      standardSelected = false;
      studentSelected = false;
      seniorSelected = false;
      pwdSelected = true;
    });
  }

  void initState() {
    super.initState();
    final tbl_users_mndb = _filipay.get('tbl_users_mndb');

    if (!tbl_users_mndb['response'].containsKey('firstName')) {
      firstNameController.text = "";
      middleNameController.text = "";
      lastNameController.text = "";
      dateofbirthController.text = "";
      addressController.text = "";
      numberController.text = "";
    } else {
      firstNameController.text = tbl_users_mndb['response']['firstName'].toString();
      middleNameController.text = tbl_users_mndb['response']['middleName'].toString();
      lastNameController.text = tbl_users_mndb['response']['lastName'].toString();
      dateofbirthController.text = tbl_users_mndb['response']['birthday'].toString();
      addressController.text = tbl_users_mndb['response']['address'].toString();
      numberController.text = tbl_users_mndb['response']['mobileNumber'].toString();
    }
  }

  void finishSetup() {
    final tbl_users_mndb = _filipay.get('tbl_users_mndb');

    if (tbl_users_mndb['response']['firstName'] == null ||
        tbl_users_mndb['response']['middleName'] == null ||
        tbl_users_mndb['response']['lastName'] == null ||
        tbl_users_mndb['response']['birthday'] == null ||
        tbl_users_mndb['response']['address'] == null ||
        tbl_users_mndb['response']['mobileNumber'] == null) {
      myComponents.error(context, "Account setup incomplete", "You need to setup your account first. Please fill al the fields to complete setup.");
    } else if (firstNameController.text != tbl_users_mndb['response']['firstName'].toString() ||
        middleNameController.text != tbl_users_mndb['response']['middleName'].toString() ||
        lastNameController.text != tbl_users_mndb['response']['lastName'].toString() ||
        dateofbirthController.text != tbl_users_mndb['response']['birthday'].toString() ||
        addressController.text != tbl_users_mndb['response']['address'].toString() ||
        numberController.text != tbl_users_mndb['response']['mobileNumber'].toString()) {
      myComponents.alert(context, () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
      }, "Unsaved Changes", "You have unsaved changes. Click OK to exit without saving?");
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainPage(),
      ));
    }
  }

  Future<void> saveChanges(BuildContext context) async {
    String user_ID = myFunc.current_user_id;
    Logger().i(user_ID);

    if (firstNameController.text.isEmpty ||
        middleNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        dateofbirthController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedOption == "NONE") {
      // Ensure an option is selected
      myComponents.error(context, "Fields cannot be empty", "Make sure to fill all text fields and select a user type. Please try again.");
    } else {
      myComponents.bookConfirmation(context, () {
        Navigator.pop(context);
        setState(() {
          _isLoading = true;
          Future.delayed(Duration(seconds: 2), () async {
            Map<String, dynamic> isUpdateResponse = await httpService.UpdateUser({
              "firstName": firstNameController.text,
              "middleName": middleNameController.text,
              "lastName": lastNameController.text,
              "type": selectedOption.toString(),
              "address": addressController.text,
              "birthday": dateofbirthController.text,
              "mobileNumber": numberController.text,
            });

            if (isUpdateResponse['messages']['code'].toString() == '0') {
              myFunc.pinMode = false;
              myFunc.loginPin = false;
              myFunc.current_user_id = isUpdateResponse['response']['id'].toString();

              _filipay.put('tbl_users_mndb', isUpdateResponse);
              final tbl_users_mndb = _filipay.get('tbl_users_mndb');

              print("CURRENT ID: ${tbl_users_mndb['response']['id']}");

              setState(() {
                _isLoading = false;
              });
              myComponents.alert(context, () {
                Navigator.pop(context);
              }, "Successful!", "Changes has been saved!.");
            } else {
              Navigator.of(context).pop();
              myComponents.errorModal(context, "${isUpdateResponse['messages']['message']}");
            }
          });
        });
      }, () {
        Navigator.pop(context);
      }, "Save changes", "Would you like to save these changes?");
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      // User canceled the image selection
    }
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        birthdate = "${DateFormat('MMMM dd, yyyy').format(_selectedDate!)}";
        dateofbirthController.text = birthdate!;
      });
  }

  @override
  Widget build(BuildContext context) {
    // dateofbirthController.text = birthdate!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      finishSetup();
                    },
                    child: Icon(
                      Icons.arrow_back_sharp,
                      color: Color.fromRGBO(28, 54, 99, 1.0),
                      size: 35.0,
                    ),
                  ),
                  PopupMenuButton<String>(
                    iconSize: 30.0,
                    iconColor: Color.fromRGBO(28, 54, 99, 1.0),
                    onSelected: (String value) {
                      if (value == 'change_pass') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                        );
                      } else if (value == 'change_pin') {
                        myFunc.pinMode = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreatePin()),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'change_pass',
                        child: Text('Change Password'),
                      ),
                      PopupMenuItem<String>(
                        value: 'change_pin',
                        child: Text('Change Pin'),
                      ),
                    ],
                    icon: Icon(Icons.more_vert), // Kebab menu icon
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: myComponents.background(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color.fromRGBO(7, 64, 87, 1.0), // Border color
                                      width: 4, // Border width
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: _selectedImage != null
                                        ? FileImage(_selectedImage!)
                                        : AssetImage("assets/general/undraw_Drink_coffee.png") as ImageProvider<Object>,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 35.0,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromRGBO(7, 64, 87, 1.0),
                                        width: 2,
                                      ),
                                      color: Color.fromRGBO(5, 80, 120, 1.0),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _pickImage(context);
                                      },
                                      icon: Icon(Icons.add_a_photo_rounded),
                                      color: Colors.white,
                                      iconSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Text(
                              'USER INFORMATION',
                              style: TextStyle(
                                color: Color.fromRGBO(32, 62, 120, 1.0),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            myComponents.coloredBackground(
                                color: Color.fromRGBO(203, 233, 242, 1.0),
                                childWidget: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "First Name",
                                            style: TextStyle(
                                              color: Color.fromRGBO(5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            controller: firstNameController,
                                          ),
                                          Text(
                                            "Middle Name",
                                            style: TextStyle(
                                              color: Color.fromRGBO(5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            controller: middleNameController,
                                          ),
                                          Text(
                                            "Last Name",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                5,
                                                80,
                                                120,
                                                1.0,
                                              ),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            controller: lastNameController,
                                          ),
                                          Text(
                                            "Mobile Number",
                                            style: TextStyle(
                                              color: Color.fromRGBO(5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            controller: numberController,
                                          ),
                                          Text(
                                            "Date of Birth",
                                            style: TextStyle(
                                              color: Color.fromRGBO(5, 80, 120, 1.0),
                                            ),
                                          ),
                                          isEditing
                                              ? Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => _selectDate(context),
                                                      child: TextFormField(
                                                        controller: dateofbirthController,
                                                        enabled: false,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        decoration: myComponents.userInfoDecoration(
                                                          BorderRadius.circular(20.0),
                                                          Color(0xff53a1d8),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: IconButton(
                                                        icon: Icon(isEditing ? Icons.close : Icons.edit, color: Color(0xff53a1d8)),
                                                        onPressed: () {
                                                          setState(() {
                                                            isEditing = !isEditing;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Stack(
                                                  children: [
                                                    TextFormField(
                                                      controller: dateofbirthController,
                                                      enabled: false,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: myComponents.userInfoDecoration(
                                                        BorderRadius.circular(20.0),
                                                        Color(0xff53a1d8),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: IconButton(
                                                        icon: Icon(isEditing ? Icons.close : Icons.edit, color: Color(0xff53a1d8)),
                                                        onPressed: () {
                                                          setState(() {
                                                            isEditing = !isEditing;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                              color: Color.fromRGBO(5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            controller: addressController,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          standard();
                                        },
                                        child: standardSelected
                                            ? myComponents.userType(
                                                text: "STANDARD",
                                                decoration: myComponents.selectedUserType(),
                                                textColor: Color.fromRGBO(24, 69, 125, 1.0))
                                            : myComponents.userType(
                                                text: "STANDARD", decoration: myComponents.defaultUserType(), textColor: Colors.white)),
                                    GestureDetector(
                                        onTap: () {
                                          student();
                                        },
                                        child: studentSelected
                                            ? myComponents.userType(
                                                text: "STUDENT",
                                                decoration: myComponents.selectedUserType(),
                                                textColor: Color.fromRGBO(24, 69, 125, 1.0))
                                            : myComponents.userType(
                                                text: "STUDENT", decoration: myComponents.defaultUserType(), textColor: Colors.white)),
                                    GestureDetector(
                                        onTap: () {
                                          senior();
                                        },
                                        child: seniorSelected
                                            ? myComponents.userType(
                                                text: "SENIOR CITIZEN",
                                                decoration: myComponents.selectedUserType(),
                                                textColor: Color.fromRGBO(24, 69, 125, 1.0))
                                            : myComponents.userType(
                                                text: "SENIOR CITIZEN", decoration: myComponents.defaultUserType(), textColor: Colors.white)),
                                    GestureDetector(
                                        onTap: () {
                                          pwd();
                                        },
                                        child: pwdSelected
                                            ? myComponents.userType(
                                                text: "PWD", decoration: myComponents.selectedUserType(), textColor: Color.fromRGBO(24, 69, 125, 1.0))
                                            : myComponents.userType(
                                                text: "PWD", decoration: myComponents.defaultUserType(), textColor: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              "Choose Standard if you’re not a student, senior or person with disability",
                              style: TextStyle(
                                fontSize: 11.0,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Get 20% discount on all public utility vehicles! Submit a valid ID.",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, color: Color.fromRGBO(46, 156, 219, 1.0)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Valid for Senior Citizen, PWD and Student only.",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                    "LIMITS AND VERIFICATIONS",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "YOUR LIMITS:",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(24, 69, 125, 1.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "DAILY COMMUTER",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(240, 139, 7, 1.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text(
                                "Cash in Limit",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Color.fromRGBO(24, 69, 125, 1.0)),
                              ),
                              Text(
                                "1,000.00",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(0, 174, 237, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpgradeLimitsPage(
                                            title: "UPGRADE YOUR LIMITS",
                                          )),
                                );
                              },
                              child: Text(
                                "UPGRADE YOUR LIMITS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            mainButtons.mainButton(
                              context: context,
                              onPressed: () {
                                saveChanges(context);
                              },
                              text: 'SAVE',
                              BackgroundColor: Color.fromRGBO(47, 50, 145, 1.0),
                              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                              BorderRadius: BorderRadius.circular(25.0),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: _isLoading ? myComponents.simulateLoading(context: context, loadText: "Processing") : Text(''),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SetupAccountTextForm extends StatefulWidget {
  const SetupAccountTextForm({
    Key? key,
    required this.myComponents,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final pageComponents myComponents;

  @override
  _SetupAccountTextFormState createState() => _SetupAccountTextFormState();
}

class _SetupAccountTextFormState extends State<SetupAccountTextForm> {
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _isEditing = true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          enabled: !_isEditing,
          decoration: widget.myComponents.userInfoDecoration(
            BorderRadius.circular(20.0),
            Color(0xff53a1d8),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              _isEditing ? Icons.edit : Icons.close,
              color: Color(0xff53a1d8),
            ),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ),
      ],
    );
  }
}
