import 'package:flutter/material.dart';

import 'helper/Messages.dart';
import 'helper/NewMessage.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
