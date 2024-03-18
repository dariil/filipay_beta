import 'package:filipay_beta/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../functions/functions.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  pageFunctions myFunc = pageFunctions();
  final _myBox = Hive.box("mybox");
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
  }

  Future<void> _initializedData() async {
    if (!_filipay.containsKey('tbl_users')) {
      myFunc.tbl_users.add({
        "user_id": 0,
        "user_email": "testmail@email.com",
        "user_pass": "user",
        "user_pin": 8888,
      });
      _filipay.put('tbl_users', myFunc.tbl_users);
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
      myFunc.tbl_user_profile =
          List<Map<dynamic, dynamic>>.from(userProfileList);
    }

    if (!_filipay.containsKey('tbl_bookings')) {
      myFunc.tbl_bookings.add({
        "booking_id": 0,
        "seat_reservation_id": 0,
        "user_id": 0,
        "reference_code": "TY5H6TW5T565YE",
        "route": "Sample Route 1",
        "date": "03/18/2024",
        "status": "PENDING",
      });
      myFunc.tbl_bookings.add({
        "booking_id": 0,
        "seat_reservation_id": 0,
        "user_id": 0,
        "reference_code": "TY5H6TW5T565YE",
        "route": "Sample Route 1",
        "date": "03/18/2024",
        "status": "PENDING",
      });
      _filipay.put('tbl_bookings', myFunc.tbl_bookings);
    } else {
      final userBookings = _filipay.get('tbl_bookings');
      myFunc.tbl_bookings = List<Map<dynamic, dynamic>>.from(userBookings);
    }

    if (!_filipay.containsKey('tbl_seat_reservation')) {
      myFunc.tbl_seat_reservation.add({
        "seat_reservation_id": 0,
        "time": "9:30 PM",
        "quantity": 1,
        "seat_number": [18],
        "price": 900
      });
      myFunc.tbl_seat_reservation.add({
        "seat_reservation_id": 0,
        "time": "9:30 PM",
        "quantity": 1,
        "seat_number": [18],
        "price": 900
      });
      _filipay.put('tbl_seat_reservation', myFunc.tbl_seat_reservation);
    } else {
      final userReservation = _filipay.get('tbl_seat_reservation');
      myFunc.tbl_seat_reservation =
          List<Map<dynamic, dynamic>>.from(userReservation);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
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
