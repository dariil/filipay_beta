// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:filipay_beta/widgets/helpCenterappbar.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({Key? key, this.title = "I need help with something."})
      : super(key: key);
  final String title;
  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  List<String> messages = [];
  TextEditingController _controller = TextEditingController();
  bool isFirstMessage = true;

  @override
  void initState() {
    super.initState();
    addReplyMessage(
        widget.title); //user's reply is fetched from Help Center Page
  }

  void addReplyMessage(String message) {
    // Add user's message
    messages.add('You: $message');

    //if Message came from ResponseChatPage
    if (isFirstMessage) {
      String botReply1;
      String botReply2;
      if (widget.title == "I need help with something.") {
        botReply1 = 'How can we help?'; // First bot reply
        messages.add(botReply1);

        //if Message came from HelpCenterPage
      } else {
        botReply1 = 'We received your message.'; // First bot reply
        botReply2 = 'To assist you better,\n' +
            'Kindly provide the following: \n\n• Reference ID: \n• Full Name: '; // Second bot reply
        messages.add(botReply1);
        messages.add(botReply2);
      }
      isFirstMessage = false; // Update isFirstMessage flag
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        DateFormat.jm().format(DateTime.now().toUtc().add(Duration(hours: 8)));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(title: widget.title),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '$formattedTime',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(241, 151, 45, 1),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUserMessage = message.startsWith('You: ');
                    bool showIcon = index == 1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: isUserMessage
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
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
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isUserMessage
                                    ? Colors.blue
                                    : Colors.grey.shade200,
                              ),
                              padding: const EdgeInsets.all(9.0),
                              child: Text(
                                message.replaceAll('You: ', ''),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isUserMessage
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          if (isUserMessage)
                            SizedBox(
                              width: 10,
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
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            Color.fromRGBO(181, 225, 238, 1).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: TextField(
                                controller: _controller,
                                minLines: 1,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'Start a Conversation...',
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Container(
                              width: 30,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(241, 151, 45, 1),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  final message = _controller.text;
                                  setState(() {
                                    messages.add('You: $message');
                                    _controller.clear();
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(
                                  Icons.send,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
