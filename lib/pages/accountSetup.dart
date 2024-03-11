import 'package:filipay_beta/pages/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';
import 'pin.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'changePasswordPage.dart';
import 'upgradeLimitsPage.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  pageComponents myComponents = pageComponents();
  pageFunctions pinPage = pageFunctions();
  InputDecoration decoration = InputDecoration();
  TextEditingController dateofbirthController = TextEditingController();
  TextEditingController controller = TextEditingController();
  bool isEditing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Handle the picked image file
    }
  }

  DateTime? _selectedDate;
  String birthdate = "December 11, 2001";

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
        dateofbirthController.text = birthdate;
      });
  }

  @override
  Widget build(BuildContext context) {
    dateofbirthController.text = birthdate;
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
                      myComponents.alert(context, () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                      }, "Unsaved Changes",
                          "You have unsaved changes. Click OK to exit without saving?");
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
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordPage()),
                        );
                      } else if (value == 'change_pin') {
                        pinPage.pinMode = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreatePin()),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
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
                                      color: Color.fromRGBO(
                                          7, 64, 87, 1.0), // Border color
                                      width: 4, // Border width
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: AssetImage(
                                        "assets/general/undraw_Drink_coffee.png"),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "First Name",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            initialText: "John Daryll",
                                          ),
                                          Text(
                                            "Middle Name",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            initialText: "Santelices",
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
                                            initialText: "Santiago",
                                          ),
                                          Text(
                                            "Date of Birth",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  5, 80, 120, 1.0),
                                            ),
                                          ),
                                          isEditing
                                              ? Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _selectDate(context),
                                                      child: TextFormField(
                                                        controller:
                                                            dateofbirthController,
                                                        enabled: false,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        decoration: myComponents
                                                            .userInfoDecoration(
                                                          BorderRadius.circular(
                                                              20.0),
                                                          Color(0xff53a1d8),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: IconButton(
                                                        icon: Icon(
                                                            isEditing
                                                                ? Icons.close
                                                                : Icons.edit,
                                                            color: Color(
                                                                0xff53a1d8)),
                                                        onPressed: () {
                                                          setState(() {
                                                            isEditing =
                                                                !isEditing;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Stack(
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          dateofbirthController,
                                                      enabled: false,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: myComponents
                                                          .userInfoDecoration(
                                                        BorderRadius.circular(
                                                            20.0),
                                                        Color(0xff53a1d8),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: IconButton(
                                                        icon: Icon(
                                                            isEditing
                                                                ? Icons.close
                                                                : Icons.edit,
                                                            color: Color(
                                                                0xff53a1d8)),
                                                        onPressed: () {
                                                          setState(() {
                                                            isEditing =
                                                                !isEditing;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  5, 80, 120, 1.0),
                                            ),
                                          ),
                                          SetupAccountTextForm(
                                            myComponents: myComponents,
                                            initialText:
                                                "Carmen Homes, Barangay San Antonio, San Pedro, Laguna",
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                24, 69, 125, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            "STANDARD",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 10.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                24, 69, 125, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            "STUDENT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 11.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                24, 69, 125, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            "SENIOR CITIZEN",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 11.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                24, 69, 125, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            "PWD",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 11.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromRGBO(46, 156, 219, 1.0)),
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
                                Container(
                                  width: 50.0,
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1.0,
                                  ),
                                ),
                                Text(
                                  "LIMITS AND VERIFICATIONS.",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  width: 50.0,
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
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cash in Limit",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromRGBO(24, 69, 125, 1.0)),
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
                                backgroundColor:
                                    Color.fromRGBO(0, 174, 237, 1.0),
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
                                // myComponents.unsavedChanges(context);
                              },
                              text: 'SAVE',
                              BackgroundColor: Color.fromRGBO(47, 50, 145, 1.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 10.0),
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
    this.initialText = '',
  }) : super(key: key);
  final String initialText;

  final pageComponents myComponents;

  @override
  _SetupAccountTextFormState createState() => _SetupAccountTextFormState();
}

class _SetupAccountTextFormState extends State<SetupAccountTextForm> {
  TextEditingController _controller = TextEditingController();
  bool _isEditing = true;

  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: _controller,
          enabled: !_isEditing,
          decoration: widget.myComponents.userInfoDecoration(
            BorderRadius.circular(20.0),
            Color(0xff53a1d8),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(_isEditing ? Icons.edit : Icons.close,
                color: Color(0xff53a1d8)),
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
