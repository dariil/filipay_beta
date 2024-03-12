import 'package:filipay_beta/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  final _myBox = Hive.box("mybox");
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
    Map<String, dynamic> userInfo = {
      "_id": "123123",
      "fname": "test fname",
      "age": 12,
    };

    _myBox.put('userInfo', userInfo);

    List<Map<String, dynamic>> transactionHistory = [
      {
        "userId": "123123",
        "fname": "test fname",
        "age": 12,
      },
      {
        "userId": "abcd",
        "fname": "test fname",
        "age": 12,
      }
    ];

    _myBox.put('transactionHistory', transactionHistory);

    final transactionHistoryList = _myBox.get('transactionHistory');

    transactionHistoryList.add({
      "userId": "123123",
      "fname": "test fname",
      "age": 12,
    });

    int index =
        transactionHistoryList.indexWhere((user) => user['userId'] == "abcd");

    transactionHistoryList[index]['fname'] = "firstname ko to bago";
    transactionHistoryList.removeWhere((user) => user['userId'] == "abcd");
    for (int i = 0; i < transactionHistoryList.length; i++) {
      print("index $i: fname: ${transactionHistoryList[i]['fname']}");
    }
    _myBox.put('transactionHistory', transactionHistory);
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
