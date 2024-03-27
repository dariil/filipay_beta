class globalToken {
  static String _getToken = '';
  String get getToken => _getToken;

  set getToken(String value) {
    if (value.isNotEmpty) {
      _getToken = value;
    }
  }
}
