import 'package:filipay_beta/pages/mainPage.dart';
import 'package:flutter/material.dart';
import '../widgets/components.dart';
import 'login.dart';
import 'accountSetup.dart';
import 'bookings.dart';
import 'eWallet.dart';
import 'transactionHistoryPage.dart';
import 'package:image_picker/image_picker.dart';
import 'TOSPage.dart';
import 'privacyPolicyPage.dart';
import '../functions/functions.dart';
import 'helpCenterPage.dart';
import 'dart:io';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  File? _selectedImage;
  pageComponents myPageComponents = pageComponents();
  final pageFunctions _functions = pageFunctions();

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int userId = _functions.current_user_id;
    String selectedOption = _functions.getAccountType(userId);

    String firstName = _functions.getFirstName(userId);
    String lastName = _functions.getLastName(userId);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildHeader(context, firstName, lastName, selectedOption),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, String firstName, String lastName, String selectedOption) => Container(
        color: Color.fromRGBO(82, 161, 217, 1.0),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Row(
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
                          setState(() {
                            _pickImage(context);
                          });
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
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$firstName $lastName",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                      color: Color.fromRGBO(7, 64, 87, 1.0),
                    ),
                  ),
                  Text(
                    "@JuanDelaCruz",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0,
                      color: Color.fromRGBO(7, 64, 87, 1.0),
                    ),
                  ),
                  Text(
                    '${selectedOption.substring(0, 1).toUpperCase()}${selectedOption.substring(1).toLowerCase()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Color.fromRGBO(7, 64, 87, 1.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myPageComponents.drawerItems(
                context: context, imagePath: "assets/general/home-regular.png", drawerItemText: "Home Page", destinationPage: MainPage()),
            myPageComponents.drawerItems(
                context: context, imagePath: "assets/general/wallet-regular.png", drawerItemText: "E-Wallet", destinationPage: EWalletPage()),
            myPageComponents.drawerItems(
                context: context,
                imagePath: "assets/general/receipt-regular.png",
                drawerItemText: "Transactions",
                destinationPage: TransactionHistoryPage(
                  title: 'Transaction History',
                )),
            myPageComponents.drawerItems(
                context: context,
                imagePath: "assets/general/user-circle-regular.png",
                drawerItemText: "Profile Settings",
                destinationPage: AccountSetup()),
            myPageComponents.drawerItems(
                context: context,
                imagePath: "assets/general/message-square-detail-regular.png",
                drawerItemText: "Help Center",
                destinationPage: HelpCenterPage(title: "Help Center")),
            myPageComponents.drawerItems(
                context: context, imagePath: "assets/general/error-regular.png", drawerItemText: "Emergency", destinationPage: LoginPage()),
            myPageComponents.drawerItems(
                context: context,
                imagePath: "assets/general/book-bookmark-regular.png",
                drawerItemText: "My Bookings",
                destinationPage: MyBookingsPage()),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
              child: Divider(color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                "Settings & Privacy",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            myPageComponents.otherDrawerItems(context: context, text: "Terms of Service", destinationPage: TOS()),
            myPageComponents.otherDrawerItems(context: context, text: "Privacy Policy", destinationPage: PrivacyPolicy()),
            // myPageComponents.otherDrawerItems(
            //     context: context,
            //     text: "Log Out",
            //     destinationPage: LoginPage()),
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: TextButton(
                onPressed: () {
                  myPageComponents.logout(context);
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 51, 102, 1.0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
