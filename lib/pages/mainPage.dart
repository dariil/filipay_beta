import 'package:filipay_beta/pages/topUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  pageFunctions sample = pageFunctions();
  bool isPayAhead = true;
  String? fff;
  double balance = 55350.00;

  void switchPanelPOTG() {
    setState(() {
      isPayAhead = false;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => EnterAmountPage()),
      // );
    });
  }

  void switchPanelPA() {
    setState(() {
      isPayAhead = true;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => EnterAmountPage()),
      // );
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
                    backgroundColor: isPayAhead
                        ? Color.fromRGBO(39, 50, 115, 1.0)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Color.fromRGBO(39, 50, 115, 1.0), width: 2.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
                  ),
                  child: Text('PAY AHEAD',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: isPayAhead
                            ? Colors.white
                            : Color.fromRGBO(82, 161, 217, 1.0),
                      )),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  sample.transportMode = 'QR Reader';
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
                    backgroundColor: isPayAhead
                        ? Colors.white
                        : Color.fromRGBO(39, 50, 115, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Color.fromRGBO(39, 50, 115, 1.0),
                          width: 2.0), // Change the color and width here
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
                  ),
                  child: Text('PAY ON THE GO',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: isPayAhead
                            ? Color.fromRGBO(82, 161, 217, 1.0)
                            : Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: [
        myComponents.background(),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Smile Always!",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Color.fromRGBO(240, 139, 7, 1.0)),
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
                              image:
                                  AssetImage("assets/transportation/sedan.png"),
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Text("₱${balance}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700)),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(44, 177, 230, 0.25),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 0.0),
                          child: isPayAhead
                              ? Column(
                                  children: [
                                    Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Jeepney",
                                              path:
                                                  "assets/transportation/jeepney.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Bus",
                                              path:
                                                  "assets/transportation/Bus.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "UV Express",
                                              path:
                                                  "assets/transportation/van.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Ship",
                                              path:
                                                  "assets/transportation/Ship.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Tricycle",
                                              path:
                                                  "assets/transportation/Trike.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Taxi",
                                              path:
                                                  "assets/transportation/taxi.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Plane",
                                              path:
                                                  "assets/transportation/Plane.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: QRCam(),
                                              modeText: "Train",
                                              path:
                                                  "assets/transportation/Train Icon.png"),
                                        ]),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: BookingPage(),
                                              modeText: "Bus",
                                              path:
                                                  "assets/transportation/Bus.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: BookingPage(),
                                              modeText: "Ship",
                                              path:
                                                  "assets/transportation/Ship.png"),
                                          myComponents.transportaionMode(
                                              padding: 10.0,
                                              context: context,
                                              page: BookingPage(),
                                              modeText: "Plane",
                                              path:
                                                  "assets/transportation/Plane.png"),
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
      ]),
    );
  }
}
