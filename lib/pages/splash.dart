import 'package:filipay_beta/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../functions/functions.dart';
import '../functions/myEncryption.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../functions/token.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  pageFunctions myFunc = pageFunctions();
  globalToken myToken = globalToken();
  MyEncryptionDecryption encrpytionMethod = MyEncryptionDecryption();
  final _filipay = Hive.box("filipay");
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ));
      }
    });
    _initializedData();
    fetchToken();
  }

  void fetchToken() async {
    String getTokenAPI = dotenv.get("GET_TOKEN", fallback: "");
    var url = Uri.parse(getTokenAPI);

    var authCredentials = base64.encode(utf8.encode('${dotenv.env['username'].toString()}:${dotenv.env['password'].toString()}'));

    var response = await http.get(
      url,
      headers: {'Authorization': 'Basic $authCredentials'},
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var token = responseData['response']['token'];
      var expiresAt = responseData['response']['expiresAt'];
      print('Token: $token');
      print('Expires At: $expiresAt');
      myToken.getToken = token;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _initializedData() async {
    if (!_filipay.containsKey('tbl_users')) {
      var ecryptedPin = MyEncryptionDecryption.encryptAES('8888').toString();
      var decryptedPin = MyEncryptionDecryption.decryptAES(ecryptedPin).toString();
      var ecryptedPassword = MyEncryptionDecryption.encryptAES('user').toString();
      var decryptedPassword = MyEncryptionDecryption.decryptAES(ecryptedPassword).toString();
      myFunc.tbl_users.add({
        "user_id": 0,
        "user_email": "testmail@email.com",
        "user_pass": ecryptedPassword,
        "user_pin": ecryptedPin,
      });
      _filipay.put('tbl_users', myFunc.tbl_users);
      final userList = _filipay.get('tbl_users');
      print("Encrypted Password: ${userList[0]['user_pass']}");
      print('Decrypted Password: $decryptedPassword');
      print("Encrypted PIN: ${userList[0]['user_pin']}");
      print('Decrypted PIN: $decryptedPin');
    } else {
      final userList = _filipay.get('tbl_users');
      myFunc.tbl_users = List<Map<dynamic, dynamic>>.from(userList);
    }

    if (!_filipay.containsKey('tbl_user_profile')) {
      myFunc.tbl_user_profile.add({
        "user_profile_id": 0,
        "user_id": 0,
        "profile_picture": "",
        "firstname": "Jhon",
        "middlename": "Juan",
        "lastname": "Dela Cruz",
        "date_of_birth": "January 1, 1995",
        "address": "Poblacion, Muntinlupa City",
        "user_type": "STANDARD",
        "cash_limits": 10000.00,
      });
      _filipay.put('tbl_user_profile', myFunc.tbl_user_profile);
    } else {
      final userProfileList = _filipay.get('tbl_user_profile');
      myFunc.tbl_user_profile = List<Map<dynamic, dynamic>>.from(userProfileList);
    }

    if (!_filipay.containsKey('tbl_recent_login')) {
      _filipay.put('tbl_recent_login', myFunc.tbl_recent_login);
    } else {
      final recentUser = _filipay.get('tbl_recent_login');
      myFunc.tbl_recent_login = List<Map<dynamic, dynamic>>.from(recentUser);
    }

    if (!_filipay.containsKey('tbl_bookings')) {
      _filipay.put('tbl_bookings', myFunc.tbl_bookings);
    } else {
      final userBookings = _filipay.get('tbl_bookings');
      myFunc.tbl_bookings = List<Map<dynamic, dynamic>>.from(userBookings);
    }

    if (!_filipay.containsKey('tbl_seat_reservation')) {
      _filipay.put('tbl_seat_reservation', myFunc.tbl_seat_reservation);
    } else {
      final userReservation = _filipay.get('tbl_seat_reservation');
      myFunc.tbl_seat_reservation = List<Map<dynamic, dynamic>>.from(userReservation);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FadeTransition(
              opacity: _animation,
              child: const Center(
                child: Image(
                  image: AssetImage('assets/general/filipay-logo-w-name.png'),
                  width: 180,
                  height: 180,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _animation,
                child: const Opacity(
                  opacity: 0.4,
                  child: Image(
                    image: AssetImage('assets/general/citybg.png'),
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
