import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nova_chess/HistoryItem.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_widgets/custom_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: CustomAppBar(
            showAppbar: false,
            scaffoldKey: scaffoldKey,
            width: width,
            height: height),
        body: BackgroundWidget(
          height: height,
          width: width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('history').doc(user?.uid).collection('games')
                .orderBy(
                  'date',
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
                  itemCount: chatDocs?.length,
                  itemBuilder: (ctx, index) {
                    final chatDoc = chatDocs?[index];
                    final date = chatDoc?.get('date').toString() ?? '';
                    final username = chatDoc?.get('username') ?? '';
                    final noMoves = chatDoc?.get('no_moves') ?? 0;
                    final key = ValueKey(chatDoc?.id);
                    final result = chatDoc?.get('result') ?? 'Undefined';
                    return HistoryItem(
                        width: width,
                        height: height,
                        date: date,
                        noMoves: noMoves,
                        username: username,
                        result: result,
                        key: key);
                  });
            },
          )),
        ));
  }
}
