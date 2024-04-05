import 'package:flutter/material.dart';
import 'package:filipay_beta/pages/newChatPage.dart';
import 'package:filipay_beta/widgets/helpCenterappbar.dart';

import 'package:intl/intl.dart';

class ResponseChatPage extends StatefulWidget {
  const ResponseChatPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ResponseChatPage> createState() => _ResponseChatPageState();
}

class _ResponseChatPageState extends State<ResponseChatPage> {
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    messages.add("A wonderful day, Jhon!");
    messages.add(getResponse(widget.title));
    messages.add("Anything else you'd like to know?");
  }

  String getResponse(String topic) {
    switch (topic) {
      case 'Filipay Card Stores':
        return 'Filipay Cards are available on:\n' +
            '• San Pedro Transport\n' +
            '• Laguna Transport\n' +
            '• Cavite Transport\n' +
            '• Sucat Transport\n' +
            '• Baclaran Transport\n' +
            "\n" +
            "Avail our cards now!";
      case 'Reservation Tracking':
        return 'Response for Reservation Tracking';
      case 'Top Up Load':
        return 'Response for Top Up Load';
      default:
        return 'Default response';
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat.jm().format(DateTime.now().toUtc().add(Duration(hours: 8)));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(title: widget.title),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '$formattedTime',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(241, 151, 45, 1)),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    bool showIcon = index == 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (showIcon)
                                Image.asset(
                                  'assets/general/chatbot-icon.png',
                                  width: 40,
                                ),
                              if (!showIcon)
                                Icon(
                                  Icons.circle,
                                  color: Colors.transparent,
                                  size: 40,
                                ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade200,
                                  ),
                                  padding: const EdgeInsets.all(9.0),
                                  child: Text(
                                    messages[index],
                                    style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 32, 32, 32)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewChatPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(18, 90, 139, 1)),
                  ),
                  child: Text(
                    "Yes, start a new conversation.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      messages.add("Glad that we helped!");
                    });

                    Future.delayed(Duration(milliseconds: 600), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("No, that's all."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
