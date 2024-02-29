import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'drawer.dart';
import 'login.dart';
import 'accountLimits.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    pageComponents myComponents = pageComponents();
    return Scaffold(
      key: scaffoldKey,
      appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      drawer:  NavDrawer(),
      body: Container(
        child: Stack(
          children:[
            myComponents.background(),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Smile Always!",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(240, 139, 7, 1.0)
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color:  Color.fromRGBO(242, 242, 242, 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child:  Padding(
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
                              color:  Color.fromRGBO(39, 50, 115, 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Image(
                                image: AssetImage("assets/transportation/sedan.png"),
                                width: 40,
                                height: 40,
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
            
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () =>
                              {
                                
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:  Color.fromRGBO(39, 50, 115, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding:  EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
                              ),
                              child:  Text(
                                'PAY AHEAD',
                                style: TextStyle(
                                  color: Colors.white,
                                )
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () =>
                              {
                                
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side:  BorderSide(color: Color.fromRGBO(39, 50, 115, 1.0), width: 1.0), // Change the color and width here
                                ),
                                padding:  EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
                              ),
                              child:  Text(
                                'PAY ON THE GO',
                                style: TextStyle(
                                  color: Color.fromRGBO(82, 161, 217, 1.0),
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 30.0,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color:  Color.fromRGBO(44, 177, 230, 0.25),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                              child: Column(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  AccountLimitsPage(), modeText: "Jeepney", path: "assets/transportation/jeepney.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "Bus", path: "assets/transportation/Bus.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "UV Express", path: "assets/transportation/van.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "Ship", path: "assets/transportation/Ship.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "Tricycle", path: "assets/transportation/Trike.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "Taxi", path: "assets/transportation/taxi.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "Plane", path: "assets/transportation/Plane.png"),
                                      myComponents.transportaionMode(padding: 10.0, context: context, page:  LoginPage(), modeText: "Train", path: "assets/transportation/Train Icon.png"),
                                    ]
                                  ),
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
          ]
        ),
      ),
    );
  }
}