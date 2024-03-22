import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:hive_flutter/hive_flutter.dart';

class MyEncryptionDecryption {
  static late encrypt.Key _key;
  static late Box _ivBox; // Hive box for storing IV
  static late Box _keyBox; // Hive box for storing encryption key

  // Initialize Hive and open the boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    _ivBox = await Hive.openBox('ivBox');
    _keyBox = await Hive.openBox('keyBox');
    _key = _getKey();
  }

  // Function to retrieve key from Hive or generate a new one if not found
  static encrypt.Key _getKey() {
    final keyBytes = _keyBox.get('key') as List<int>?;
    if (keyBytes != null) {
      return encrypt.Key(Uint8List.fromList(keyBytes));
    } else {
      final newKey = encrypt.Key.fromSecureRandom(32);
      _keyBox.put('key', newKey.bytes);
      return newKey;
    }
  }

  // Function to save IV to Hive
  static Future<void> saveIV(encrypt.IV iv) async {
    await _ivBox.put('iv', iv.bytes);
  }

  // Function to retrieve IV from Hive or generate a new one if not found
  static encrypt.IV getIV() {
    final ivBytes = _ivBox.get('iv') as List<int>? ?? List<int>.filled(16, 0);
    return encrypt.IV(Uint8List.fromList(ivBytes));
  }

  static encryptAES(text) {
    final iv = getIV(); // Retrieve IV from Hive
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted.base64;
  }

  static decryptAES(String text) {
    final iv = getIV(); // Retrieve IV from Hive
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    return encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
  }
}
