// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/splash.dart';
import 'functions/myEncryption.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await MyEncryptionDecryption.init();
  await dotenv.load(fileName: '.env');
  // if (MyEncryptionDecryption.getIV().bytes.isEmpty) {
  //   MyEncryptionDecryption.generateAndSaveIV();
  // }
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  var filipay = await Hive.openBox('filipay');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
