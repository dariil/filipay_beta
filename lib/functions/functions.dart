import 'package:hive_flutter/hive_flutter.dart';

class pageFunctions {
  final _filipay = Hive.box("filipay");
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

  static List<Map<String, dynamic>> _tbl_users = [];

  List<Map<String, dynamic>> get tbl_users => _tbl_users;

  static int? _user_id;

  // Future<void> _getAllData() async {
  //   final userList = _filipay.get('tbl_users');
  //   _user_id = userList.length;
  // }

  int get user_id => _user_id!;

  set user_id(int value) {
    _user_id = value;
  }
}
