import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';

import '../custom_widgets/MessageBubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final user = FirebaseAuth.instance.currentUser;
    return BackgroundWidgetAdventureMode(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data?.docs;
            return ListView.builder(
                reverse: true,
                itemCount: chatDocs?.length,
                itemBuilder: (ctx, index) {
                  final chatDoc = chatDocs?[index];
                  final text = chatDoc?.get('text') ?? '';
                  final username = chatDoc?.get('username') ?? '';
                  final isMe = chatDoc?.get('userId') == user?.uid;
                  final key = ValueKey(chatDoc?.id);
                  return MessageBubble(text, username, isMe, key: key);
                });
          },
        ),
        height: height,
        width: width);
  }
}
