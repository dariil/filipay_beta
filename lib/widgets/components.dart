import 'package:filipay_beta/pages/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:slider_button/slider_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../functions/functions.dart';
import '../pages/bookings.dart';
import '../pages/waitingConfirmationPage.dart';
import '../pages/login.dart';
import '../functions/httpRequest.dart';

class pageComponents {
  pageFunctions pageFunc = pageFunctions();
  httprequestService httpService = httprequestService();
  Align background() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: 0.4,
        child: Image(
          image: AssetImage("assets/general/citybg.png"),
        ),
      ),
    );
  }

  InputDecoration textFieldWhite({required BorderRadius}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius,
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  final _filipay = Hive.box("filipay");

  Future<void> _getData() async {
    final userList = _filipay.get('tbl_users');
    print(userList[0]['user_email']);
    print("GUMAGANA");
  }

  Future<void> _getAllData() async {
    final userList = _filipay.get('tbl_users');
    final userProfileList = _filipay.get('tbl_user_profile');
    for (int i = 0; i < userList.length; i++) {
      print("===========================================");
      print("email: ${userList[i]['user_email']}");
      print("password: ${userList[i]['user_pass']}");
      print("user id: ${userList[i]['user_id']}");
      print("user pin: ${userList[i]['user_pin']}");
      print("\n\n");
      print("profile id: ${userProfileList[i]['user_profile_id']}");
      print("user id: ${userProfileList[i]['user_id']}");
      print("profile picture: ${userProfileList[i]['profile_picture']}");
      print("first name: ${userProfileList[i]['firstname']}");
      print("middle name: ${userProfileList[i]['middlename']}");
      print("last name: ${userProfileList[i]['lastname']}");
      print("date of birth: ${userProfileList[i]['date_of_birth']}");
      print("address: ${userProfileList[i]['address']}");
      print("user type: ${userProfileList[i]['user_type']}");
      print("cashin limits: ${userProfileList[i]['cashin_limits']}");
      print("===========================================");
    }
  }

  Future<void> _getAllBookingInfo() async {
    final userBookings = _filipay.get('tbl_bookings');
    final userReservation = _filipay.get('tbl_seat_reservation');
    for (int i = 0; i < userBookings.length; i++) {
      print("===========================================");
      print("\n\n");
      print("booking id: ${userBookings[i]['booking_id']}");
      print("seat reservation id: ${userBookings[i]['seat_reservation_id']}");
      print("user id: ${userBookings[i]['user_id']}");
      print("reference code: ${userBookings[i]['reference_code']}");
      print("route: ${userBookings[i]['route']}");
      print("date: ${userBookings[i]['date']}");
      print("status: ${userBookings[i]['status']}");
      print("\n\n");
      print("seat reservation id: ${userReservation[i]['seat_reservation_id']}");
      print("booking id: ${userReservation[i]['booking_id']}");
      print("time: ${userReservation[i]['time']}");
      print("quantity: ${userReservation[i]['quantity']}");
      print("seat number: ${userReservation[i]['seat_number']}");
      print("price: ${userReservation[i]['price']}");
      print("\n\n");
      print("===========================================");
    }
  }

  Future<void> _removeAllData() async {
    final userList = _filipay.get('tbl_users');
    userList.clear();
    print("DATA REMOVED SUCCESSFULLY");
    _filipay.put('tbl_users', userList);
  }

  ElevatedButton otherSignupBtn({
    required BuildContext context,
    required String imagePath,
    required String buttonText,
    required buttonColor,
    required Color buttonTextColor,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      onPressed: () {
        _getAllData();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            image: AssetImage(imagePath),
            width: 28.0,
            height: 28.0,
          ),
          Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: buttonTextColor,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding transportaionMode({required double padding, required BuildContext context, required page, required String modeText, required String path}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              pageFunc.transportMode = modeText;
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(82, 161, 217, 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(180, 224, 237, 1.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Image(
                      image: AssetImage(path),
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(modeText),
        ],
      ),
    );
  }

  Padding topUpMode({required double padding, required BuildContext context, required page, required String modeText, required String path}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Image(
                    image: AssetImage(path),
                    width: 120.0,
                    height: 120.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(modeText),
        ],
      ),
    );
  }

  ListTile drawerItems({required BuildContext context, required String imagePath, required String drawerItemText, required destinationPage}) {
    return ListTile(
      leading: Image(width: 25, height: 25, image: AssetImage(imagePath)),
      title: Text(
        drawerItemText,
        style: TextStyle(color: Color.fromRGBO(0, 51, 102, 1.0)),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => destinationPage),
      ),
    );
  }

  Padding otherDrawerItems({required BuildContext context, required String text, required destinationPage}) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0),
      child: TextButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destinationPage),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromRGBO(0, 51, 102, 1.0),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void showLoading(BuildContext context, String label) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {},
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${label.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      'assets/general/loading-confirmation.gif',
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Text(
                      'Please wait...',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Stack simulateLoading({required BuildContext context, required String loadText}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.17,
          width: MediaQuery.of(context).size.width * 0.50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Image(
                  image: AssetImage('assets/general/loading-confirmation.gif'),
                  width: 70,
                ),
              ),
              Text(
                loadText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack simulateConnectLoading({required BuildContext context, required String loadText}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage('assets/general/loading-confirmation.gif'),
                  width: 70,
                ),
                Text(
                  loadText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    color: Color.fromRGBO(82, 161, 217, 1.0),
                  ),
                ),
                Text(
                  "Linking your FILIPAY account to your FILIPAY Card.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration userInfoDecoration(BorderRadius borderRadius, Color color) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Container coloredBackground({required color, required childWidget}) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: childWidget,
    );
  }

  AppBar appBar({scaffoldKey}) {
    final tbl_users_mndb = _filipay.get('tbl_users_mndb');
    return AppBar(
      backgroundColor: Color.fromRGBO(44, 177, 230, 1.0),
      centerTitle: true,
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('assets/general/filipay-logo.png'),
        ),
      ]),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        color: Colors.white,
      ),
      actions: [
        Container(
          width: 150.0,
          child: Text(
            "Hello, ${tbl_users_mndb['response']['firstName'].toString()}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromRGBO(39, 50, 115, 1.0),
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 20.0),
      ],
    );
  }

  Container headerPageLabel(BuildContext context, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Stack(children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_sharp,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            labelText,
            style: TextStyle(
              color: Color(0xffef8b06),
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ]),
    );
  }

  Column bookingDetails(BuildContext context, String amount, String referenceCode, String route, String date, String time) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("PHP ${amount}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Reference Code"),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                referenceCode,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Route"),
            Container(
                width: 210.0,
                child: Text(
                  route,
                  textAlign: TextAlign.right,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Date"),
            Text(date),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Time"),
            Text(time),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Status"),
            GestureDetector(
              onTap: () {
                bookingQR(
                  context,
                );
              },
              child: Text(
                "View QR Code",
                style: TextStyle(
                  color: Color(0xffed8f10),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container userType({required String text, required BoxDecoration decoration, required Color textColor}) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 80.0,
      height: 50.0,
      decoration: decoration,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontSize: 10.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  BoxDecoration selectedUserType() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 2.0,
          color: Color.fromRGBO(24, 69, 125, 1.0),
        ));
  }

  BoxDecoration defaultUserType() {
    return BoxDecoration(
        color: Color.fromRGBO(24, 69, 125, 1.0),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 2.0,
          color: Color.fromRGBO(24, 69, 125, 1.0),
        ));
  }

  void alert(BuildContext context, Function() onOkPressed, String alertTitle, String alertDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  alertTitle,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffef8b06),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  alertDescription,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: onOkPressed,
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Color.fromRGBO(24, 69, 125, 1.0),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void slider(BuildContext context, Function() onOkPressed, double loadAmount) {
    double serviceFee = 5.00;

    double totalAmount = loadAmount + serviceFee;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "PHP",
                      style: TextStyle(
                        color: Color(0xff18467e),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${loadAmount}",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Method:",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text("Online"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Fee:",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text("${serviceFee.toStringAsFixed(2)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TOTAL:",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "${totalAmount.toStringAsFixed(2)}",
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: SliderButton(
                    shimmer: true,
                    vibrationFlag: true,
                    width: 230,
                    height: 60.0,
                    radius: 25,
                    buttonColor: Color(0xffef8b06),
                    backgroundColor: Color(0xffe0e0e0),
                    highlightedColor: Colors.black,
                    baseColor: Colors.red,
                    action: () async {
                      onOkPressed();
                      return true;
                    },
                    label: Text(
                      "Slide to confirm",
                      style: TextStyle(
                        color: Color(0xff4a4a4a),
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void loadConfirmed(
    BuildContext context,
    Function() onOkPressed,
    String alertTitle,
    String alertDescription,
    double loadAmount,
  ) {
    String referenceCode = "FP${Random().nextInt(999999).toString().padLeft(6, '0')}";
    DateTime utcTime = DateTime.now().toUtc();
    Duration philippinesOffset = Duration(hours: 8);
    DateTime philippinesTime = utcTime.add(philippinesOffset);
    String formattedDate = DateFormat('yyyy-MM-dd').format(philippinesTime);
    String formattedTime = DateFormat('h:mm a').format(philippinesTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  alertTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffef8b06),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  alertDescription,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Amount: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "₱${loadAmount.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(13, 93, 158, 1.0)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  "Reference Code: $referenceCode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Date: $formattedDate",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Time: $formattedTime",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    width: 180.0,
                    height: 180.0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Color.fromRGBO(13, 93, 158, 1.0),
                            width: 5,
                          ),
                          color: Colors.white,
                        ),
                        child: QrImageView(
                          data: referenceCode,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onOkPressed();
                    try {
                      String _currently_logged_user = pageFunc.current_user_id;
                      Map<dynamic, dynamic> transactionDetails = {
                        'userId': _currently_logged_user,
                        'amount': loadAmount,
                        'Payment Method': 'Online',
                        'referenceCode': referenceCode,
                        'date': formattedDate,
                        'time': formattedTime,
                      };

                      List<Map<dynamic, dynamic>> userTransactions = _filipay.get(
                        'user_transactions_$_currently_logged_user',
                        defaultValue: [],
                      ).cast<Map<dynamic, dynamic>>();
                      userTransactions.add(transactionDetails);
                      _filipay.put(
                        'user_transactions_$_currently_logged_user',
                        userTransactions,
                      );

                      print('User Transactions: $userTransactions');
                    } catch (e) {
                      print('Error storing user transactions: $e');
                    }
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Color.fromRGBO(24, 69, 125, 1.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void error(BuildContext context, String alertTitle, String alertDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    alertTitle,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  alertDescription,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff283474),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void bookConfirmation(BuildContext context, Function() onOkPressed, Function() onCancelPressed, String alertTitle, String alertDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  alertTitle,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffef8b06),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  alertDescription,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onCancelPressed,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextButton(
                        onPressed: onOkPressed,
                        child: Text(
                          "CONTINUE",
                          style: TextStyle(
                            color: Color.fromRGBO(24, 69, 125, 1.0),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void bookSuccessful(BuildContext context, String route, String schedule, double fare) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Booking Successful!",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffef8b06),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Route:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: 180.0,
                          child: Text(
                            route,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Schedule:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          schedule,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fare:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "₱${fare}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyBookingsPage()),
                      );
                    },
                    child: Text(
                      "EXIT",
                      style: TextStyle(
                        color: Color.fromRGBO(24, 69, 125, 1.0),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void paymentSuccessful(BuildContext context, double amount) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Payment Successful!",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff003366),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "₱${amount}",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Amount: ₱${amount}",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Discount: ₱${0.0}",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    thickness: 2.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Reference ID:"),
                    Container(
                        width: 120.0,
                        child: Text(
                          "19036766422024",
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pay Time:"),
                    Container(
                        width: 120.0,
                        child: Text(
                          "March 19, 2024 | 2:10 PM",
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                SizedBox(height: 50.0),
                mainButtons.mainButton(
                    context: context,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                    text: "THANK YOU!",
                    BackgroundColor: Color(0xff29328f),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    BorderRadius: BorderRadius.circular(8.0)),
              ],
            ),
          ));
        });
  }

  void generateQR(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 330,
            width: 370,
            child: Center(
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PAY USING QR CODE",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffef8a05),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: 220,
                          height: 220,
                          child: Container(
                            child: QrImageView(
                              data: 'QWERTYUIOP',
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          actions: <Widget>[
            Center(
                child: mainButtons.mainButton(
              context: context,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingConfirmationPage(title: "${pageFunc.transportMode}")));
              },
              text: "QR SCANNED",
              BackgroundColor: Color(0xff18467e),
              padding: 10.0,
              BorderRadius: BorderRadius.circular(8.0),
            )),
          ],
        );
      },
    );
  }

  void errorModal(BuildContext context, String label) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: "Error",
        text: label.toUpperCase(),
      ),
    );
  }

  void logout(BuildContext context) {
    _filipay.put('tbl_recent_login', pageFunc.tbl_recent_login);
    final recentUser = _filipay.get('tbl_recent_login');
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        showCancelBtn: true,
        type: ArtSweetAlertType.info,
        confirmButtonText: "Logout",
        title: "Confirm Logout",
        text: "Are you sure you want to logout?",
        onConfirm: () {
          recentUser.clear();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ),
    );
  }
}

class logoutFormField extends StatefulWidget {
  const logoutFormField({
    super.key,
  });

  @override
  State<logoutFormField> createState() => _logoutFormFieldState();
}

class _logoutFormFieldState extends State<logoutFormField> {
  bool _obscureText = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
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

void bookingQR(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 350,
          width: 370,
          child: Center(
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "SCAN TO VIEW BOOKING STATUS",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffef8a05),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: Container(
                        child: QrImageView(
                          data: 'QWERTYUIOP',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        actions: <Widget>[
          Center(
              child: mainButtons.mainButton(
            context: context,
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: "DONE",
            BackgroundColor: Color(0xff18467e),
            padding: 10.0,
            BorderRadius: BorderRadius.circular(8.0),
          )),
        ],
      );
    },
  );
}

class mainButtons {
  static Container mainButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    required BackgroundColor,
    required padding,
    required BorderRadius,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          elevation: 5,
          textStyle: TextStyle(
            fontSize: 16.0,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  static ElevatedButton loadButtons({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    required BackgroundColor,
    required textColor,
    required padding,
    required radius,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: BackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
        ),
        padding: padding,
        elevation: 2,
        textStyle: TextStyle(
          fontSize: 16.0,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w900,
          fontSize: 22.0,
        ),
      ),
    );
  }
}

class InputDecorations {
  static InputDecoration passwordFields({
    required bool obscureText,
    required VoidCallback togglePassword,
    required BorderRadius borderRadius,
  }) {
    return InputDecoration(
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: togglePassword,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
