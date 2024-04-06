import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math';

class pageFunctions {
  final _filipay = Hive.box("filipay");
  void initState() {}

  String generateRandomId(int length) {
    var random = Random();
    var codeUnits = List.generate(
      length,
      (index) => random.nextInt(1114111 - 32) + 32,
    );
    return String.fromCharCodes(codeUnits);
  }

  static String _transportMode = "QR Reader";

  String get transportMode => _transportMode;

  set transportMode(String value) {
    if (value.isNotEmpty) {
      _transportMode = value;
    }
  }

  static bool _createNew = false;

  bool get pinMode => _createNew;

  set pinMode(bool value) {
    _createNew = value;
  }

  static bool _loginPin = false;
  bool get loginPin => _loginPin;
  set loginPin(bool value) {
    _loginPin = value;
  }

  static String _date = "N/A";
  static String _headerDate = "N/A";

  String get dateSelected => _date;

  set dateSelected(String value) {
    _date = value;
  }

  String get headerDateSelected => _headerDate;

  set headerDateSelected(String value) {
    _headerDate = value;
  }

  static String _reservedTime = "N/A";

  String get reservedTime => _reservedTime;

  set reservedTime(String value) {
    _reservedTime = value;
  }

  static String? _user_id;
  String get user_id => _user_id!;

  set user_id(String value) {
    _user_id = value;
  }

  static List<Map<dynamic, dynamic>> _tbl_users = [];
  List<Map<dynamic, dynamic>> get tbl_users => _tbl_users;

  set tbl_users(List<Map<dynamic, dynamic>> value) {
    _tbl_users = value;
  }

  static List<Map<dynamic, dynamic>> _tbl_user_profile = [];
  List<Map<dynamic, dynamic>> get tbl_user_profile => _tbl_user_profile;

  set tbl_user_profile(List<Map<dynamic, dynamic>> value) {
    _tbl_user_profile = value;
  }

  static List<Map<dynamic, dynamic>> _tbl_recent_login = [];
  List<Map<dynamic, dynamic>> get tbl_recent_login => _tbl_recent_login;

  set tbl_recent_login(List<Map<dynamic, dynamic>> value) {
    _tbl_recent_login = value;
  }

  static int? _user_profile_id;
  int get user_profile_id => _user_profile_id!;

  set user_profile_id(int value) {
    _user_profile_id = value;
  }

  static String _currently_logged_user = "";
  String get current_user_id => _currently_logged_user;

  set current_user_id(String value) {
    _currently_logged_user = value;
  }

  static List<Map<dynamic, dynamic>> _tbl_bookings = [];
  List<Map<dynamic, dynamic>> get tbl_bookings => _tbl_bookings;

  set tbl_bookings(List<Map<dynamic, dynamic>> value) {
    _tbl_bookings = value;
  }

  static List<Map<dynamic, dynamic>> _tbl_seat_reservation = [];
  List<Map<dynamic, dynamic>> get tbl_seat_reservation => _tbl_seat_reservation;

  set tbl_seat_reservation(List<Map<dynamic, dynamic>> value) {
    _tbl_seat_reservation = value;
  }

  static List<Map<dynamic, dynamic>> _user_ewallet = [];
  List<Map<dynamic, dynamic>> get user_ewallet => _user_ewallet;

  set user_ewallet(List<Map<dynamic, dynamic>> value) {
    _user_ewallet = value;
  }

  static int? _active_booking_id;

  set active_booking_id(int value) {
    _active_booking_id = value;
  }

  int get active_booking_id => _active_booking_id!;

  static double _remaining_balance = 0.00;

  set remaining_balance(double value) {
    _remaining_balance = value;
  }

  double get remaining_balance => _remaining_balance;

  double getBalance() {
    return _filipay.get('balance_${_currently_logged_user}', defaultValue: 0.0);
  }

  static List<Map<String, dynamic>> _user_transactionHistory = [];
  List<Map<String, dynamic>> get transactionHistory => _user_transactionHistory;

  void addTransaction(Map<String, dynamic> transactionDetails) {
    _user_transactionHistory.add(transactionDetails);
  }

  static String _serverPin = "N/A";

  String get serverPin => _serverPin;

  set serverPin(String value) {
    _serverPin = value;
  }
}
