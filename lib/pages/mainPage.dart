import 'package:filipay_beta/functions/httpRequest.dart';
import 'package:filipay_beta/pages/qrPay.dart';
import 'package:filipay_beta/pages/topUpPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import '../widgets/components.dart';
import 'drawer.dart';
import 'qrcam.dart';
import '../functions/functions.dart';
import 'bookingPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Box _filipay = Hive.box('filipay');
  httprequestService httpService = httprequestService();

  pageFunctions myFunc = pageFunctions();
  bool _alertDialogShown = false;
  bool isPayAhead = true;
  String? fff;
  double balance = 0.0;

  @override
  void initState() {
    // final tbl_users_mndb = _filipay.get('tbl_users_mndb');
    super.initState();
    Logger().i(myFunc.current_user_id);
    _initializeWallet();
    // Logger().i(tbl_users_mndb);
  }

  void _initializeWallet() async {
    Map<String, dynamic> getWalletResponse = await httpService.getWallet();
    double balance = getWalletResponse['response']['balance'].toDouble();
    setState(() {
      myFunc.remaining_balance = balance;
    });
  }

  Future<void> updateBalance() async {
    // Wait for the response from the httpService.getWallet() call
    Map<String, dynamic> getWalletResponse = await httpService.getWallet();

    // Access the response data and update the state
    setState(() {
      double balance = getWalletResponse['response']['balance'].toDouble();
      myFunc.remaining_balance = balance;
    });
  }

  void switchPanelPOTG() {
    setState(() {
      isPayAhead = false;
    });
  }

  void switchPanelPA() {
    setState(() {
      isPayAhead = true;
    });
  }

  bool checkRecentLogs() {
    final recentUser = _filipay.get('tbl_recent_login');
    if (recentUser == null || (recentUser as List).isEmpty) {
      print("Empty");
      return true;
    } else {
      print("Not Empty");
      return false;
    }
  }

  void enableBiometrics() {
    _filipay.put('tbl_recent_login', myFunc.tbl_recent_login);
    final recentUser = _filipay.get('tbl_recent_login');

    final tbl_users_mndb = _filipay.get('tbl_users_mndb');
    recentUser.add({
      "recent_user_id": myFunc.current_user_id,
      "recent_user_email": tbl_users_mndb['response']['email'],
      "recent_user_pin": tbl_users_mndb['response']['pin'],
      "recent_user_firstname": tbl_users_mndb['response']['firstName'],
      "recent_user_middlename": tbl_users_mndb['response']['middleName'],
      "recent_user_lastname": tbl_users_mndb['response']['lastName'],
      "recent_user_type": tbl_users_mndb['response']['type'],
      "recent_user_address": tbl_users_mndb['response']['address'],
      "recent_user_birthday": tbl_users_mndb['response']['birthday'],
      "recent_user_mobile": tbl_users_mndb['response']['mobileNumber'],
      "recent_user_date_created": tbl_users_mndb['response']['createdAt'],
      "recent_user_date_updated": tbl_users_mndb['response']['updatedAt'],
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    pageComponents myComponents = pageComponents();
    return Scaffold(
      key: scaffoldKey,
      appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      drawer: NavDrawer(),
      bottomNavigationBar: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Color(0xffd0e2f3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => {
                    switchPanelPA(),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPayAhead ? Color.fromRGBO(39, 50, 115, 1.0) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Color.fromRGBO(39, 50, 115, 1.0), width: 2.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
                  ),
                  child: Text('PAY AHEAD',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: isPayAhead ? Colors.white : Color.fromRGBO(82, 161, 217, 1.0),
                      )),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  myFunc.transportMode = 'QR Reader';
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRCam(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff52a1d9),
                      width: 5.0,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      width: 40.0,
                      image: AssetImage("assets/general/qr-code-scan.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Container(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => {
                    switchPanelPOTG(),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPayAhead ? Colors.white : Color.fromRGBO(39, 50, 115, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Color.fromRGBO(39, 50, 115, 1.0), width: 2.0), // Change the color and width here
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
                  ),
                  child: Text('PAY ON THE GO',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: isPayAhead ? Color.fromRGBO(82, 161, 217, 1.0) : Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: [
        myComponents.background(),
        RefreshIndicator(
          onRefresh: updateBalance,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Smile Always!",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, color: Color.fromRGBO(240, 139, 7, 1.0)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 20.0),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 242, 242, 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "TRANSPORTATION",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0,
                              color: Color.fromRGBO(32, 62, 120, 1.0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(39, 50, 115, 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Image(
                                image: AssetImage("assets/transportation/sedan.png"),
                                width: 40,
                                height: 40,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(39, 50, 115, 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available Balance",
                              style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            Text("₱${myFunc.remaining_balance}", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TopUpPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text("TOP UP"),
                                Icon(
                                  Icons.add,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(44, 177, 230, 0.25), borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                            child: isPayAhead
                                ? Column(
                                    children: [
                                      Wrap(alignment: WrapAlignment.center, children: [
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: QRCam(),
                                            modeText: "Jeepney",
                                            path: "assets/transportation/jeepney.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0, context: context, page: QRCam(), modeText: "Bus", path: "assets/transportation/Bus.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: QRCam(),
                                            modeText: "UV Express",
                                            path: "assets/transportation/van.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0, context: context, page: QRCam(), modeText: "Ship", path: "assets/transportation/Ship.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: QRCam(),
                                            modeText: "Tricycle",
                                            path: "assets/transportation/Trike.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0, context: context, page: QRCam(), modeText: "Taxi", path: "assets/transportation/taxi.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: QRCam(),
                                            modeText: "Plane",
                                            path: "assets/transportation/Plane.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: QRCam(),
                                            modeText: "Train",
                                            path: "assets/transportation/Train Icon.png"),
                                      ]),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Wrap(alignment: WrapAlignment.center, children: [
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: BookingPage(),
                                            modeText: "Bus",
                                            path: "assets/transportation/Bus.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: BookingPage(),
                                            modeText: "Ship",
                                            path: "assets/transportation/Ship.png"),
                                        myComponents.transportaionMode(
                                            padding: 10.0,
                                            context: context,
                                            page: BookingPage(),
                                            modeText: "Plane",
                                            path: "assets/transportation/Plane.png"),
                                      ]),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        checkRecentLogs()
            ? FutureBuilder(
                future: Future.delayed(Duration(seconds: 2)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(); // Show a loading indicator while waiting
                  } else {
                    // Your logic here
                    print('Do something after 2 seconds');
                    if (!_alertDialogShown) {
                      _alertDialogShown = true; // Set flag to true to indicate AlertDialog shown
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.28,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Enable biometrics authentication?",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Use your biometric to sign and confirm payments. You can always set it up later in Settings.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Not now",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              enableBiometrics();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Enable",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    }
                    return SizedBox(); // Placeholder widget after showing AlertDialog
                  }
                },
              )
            : SizedBox(),
      ]),
    );
  }
}
