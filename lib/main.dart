import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/splash.dart';

void main() async {
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
