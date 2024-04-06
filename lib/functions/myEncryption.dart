import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyEncryptionDecryption {
  static late Box _ivBox;

  
  static Future<void> init() async {
    await Hive.initFlutter();
    _ivBox = await Hive.openBox('ivBox');
  }

  static Future<void> saveIV(encrypt.IV iv) async {
    await _ivBox.put('iv', iv.bytes);
  }

  static encrypt.IV getIV() {
    final ivBytes = _ivBox.get('iv') as List<int>? ?? List<int>.filled(16, 0);
    return encrypt.IV(Uint8List.fromList(ivBytes));
  }

  static encryptAES(text) {
    final key = encrypt.Key.fromUtf8(dotenv.env['key'].toString());
    final iv = getIV(); 
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted.base64;
  }

  static decryptAES(String text) {
    final key = encrypt.Key.fromUtf8(dotenv.env['key'].toString());
    final iv = getIV(); 
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    return encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
  }
}
