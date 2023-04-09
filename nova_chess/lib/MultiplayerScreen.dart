import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nova_chess/custom_widgets/custom_button_blue.dart';
import 'package:nova_chess/custom_widgets/custom_text_field.dart';
import 'package:nova_chess/helper/routes.dart';
import 'package:nova_chess/helper/user.dart';

import 'custom_widgets/custom_app_bar.dart';

class MultiplayerScreen extends StatefulWidget {
  @override
  State<MultiplayerScreen> createState() => _MultiplayerScreenState();
}

class _MultiplayerScreenState extends State<MultiplayerScreen> {
  late double width;
  late double height;
  bool _userMove = true;
  bool _firstEnterScreen = true;
  String _allMoves = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ChessBoardController _chessBoardController = ChessBoardController();
  final FirebaseDatabase database = FirebaseDatabase.instance;

  String _generateRandomURL() {
    var temp = "";
    const String alpha_numeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    for (int i = 0; i < 10; i++) {
      var rand = Random();
      var index = rand.nextInt(35);
      temp += alpha_numeric.substring(index, index + 1);
    }

    return temp;
  }

  Future<void> _sendMove(UserLogIn user, String allMoves) async {
    DatabaseReference ref = database.ref('meciuri/${user.gameId}');
    ref.update({
      'moves': allMoves,
    });
  }

  Future<void> _updateMove(UserLogIn user, ChessBoardController _chessBoardController, _allMoves, context, String uid) async {
    DatabaseReference ref_player2 =
        database.ref('meciuri/${user.gameId}/moves');
    ref_player2.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != _allMoves) {
        _chessBoardController.loadPGN(data as String);
        if (_chessBoardController.isGameOver()) {
          var gameState = _chessBoardController.game.turn;
          if (gameState == 'w') {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Player 1 did win'),
                  actions: [
                    CustomButtonBlue(
                      width: width * 0.2,
                      height: height * 0.1,
                      text: 'Cancel',
                      textSize: 14,
                      onPressed: () {
                        FirebaseFirestore.instance.collection('history').doc(uid).collection('games}').doc(user.gameId).set(
                          {
                            'date' : Timestamp.now(),
                            'no_moves' : _chessBoardController.getMoveCount(),
                            'result' : user.player1 ? 'WIN' : 'Lose',
                            'username' : user.player1 ? 'Ioan' : 'Mircea',
                            'moves' : _chessBoardController.getSan(),
                          }
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(OwnRouter.homeRoute, arguments: user, (route) => false);
                      }
                    ),
                    CustomButtonBlue(
                      width: width * 0.2,
                      height: height * 0.1,
                      text: 'Restart',
                      textSize: 14,
                      onPressed: () {
                        var collection = FirebaseFirestore.instance.collection('history').doc(uid).collection('games/${user.gameId}').add(
                          {
                            'date' : Timestamp.now(),
                            'no_moves' : _chessBoardController.getMoveCount(),
                            'result' : user.player1 ? 'WIN' : 'Lose',
                            'username' : user.player1 ? 'Ioan' : 'Mircea',
                            'moves' : _chessBoardController.getSan(),
                          }
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(OwnRouter.multiplayerRoute, arguments: user, (route) => false);
                      },
                    ),
                  ],
                );
              }
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Player 2 did win'),
                  actions: [
                    CustomButtonBlue(
                      width: width * 0.2,
                      height: height * 0.1,
                      text: 'Cancel',
                      textSize: 14,
                      onPressed: () => {
                        Navigator.of(context).pushNamedAndRemoveUntil(OwnRouter.homeRoute, arguments: user, (route) => false)
                      }
                    ),
                    CustomButtonBlue(
                      width: width * 0.2,
                      height: height * 0.1,
                      text: 'Restart',
                      textSize: 14,
                      onPressed: () => {
                        _chessBoardController.resetBoard(),
                        _sendMove(user, ''),
                        Navigator.of(context).pop(),
                      },
                    ),
                  ],
                );
              }
            );
          }
        }
        setState(() {
          _userMove = !_userMove;
        });
      }
    });
  }

  Future<void> _initGame(UserLogIn user, context) async {
    user.gameId = _generateRandomURL();
    DatabaseReference ref = database.ref('meciuri/${user.gameId}');
    await ref.set({'player1': "ioan", 'player2': '', 'moves': ''});

    var collection = FirebaseFirestore.instance.collection('chat');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    DatabaseReference ref_player2 =
        database.ref('meciuri/${user.gameId}/player2');
    ref_player2.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data as String != '') {
        Navigator.pop(context);
      }
    });

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(user.gameId),
            actions: [
              CustomButtonBlue(
                  width: width * 0.4,
                  height: height * 0.1,
                  text: 'Close',
                  textSize: 14,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        OwnRouter.homeRoute, arguments: user, (route) => false);
                  }),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _chessBoardController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final user = ModalRoute.of(context)!.settings.arguments as UserLogIn;
    final auth = FirebaseAuth.instance.currentUser;

    if (user.gameId == '') {
      setState(() {
        _initGame(user, context);
      });
    }

    if (!user.player1 && _firstEnterScreen) {
      _firstEnterScreen = false;
      _userMove = !_userMove;
      _updateMove(user, _chessBoardController, _allMoves, context, auth!.uid);
    }

    return Scaffold(
      appBar: CustomAppBar(
          showAppbar: false,
          scaffoldKey: scaffoldKey,
          width: width,
          height: height),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(OwnRouter.chatRoute);
      }),
      body: BackgroundLevelWidget(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.2),
              ChessBoard(
                controller: _chessBoardController,
                enableUserMoves: true,
                boardColor: BoardColor.darkBrown,
                boardOrientation:
                    (user.player1) ? PlayerColor.white : PlayerColor.black,
                onMove: () {
                  setState(() {
                    _userMove = !_userMove;
                  });
                },
                arrows: [],
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(0.7),
                      border: Border.all(width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: width * 0.8,
                  height: height * 0.25,
                  child: ListView.builder(
                      itemCount: _chessBoardController.getSan().length,
                      itemBuilder: (BuildContext ctx, int index) {
                        _allMoves = _chessBoardController.getSan().fold(
                            '',
                            (previousValue, element) =>
                                previousValue + ' ' + (element ?? ''));
                        _sendMove(user, _allMoves);
                        _updateMove(user, _chessBoardController, _allMoves, context, auth!.uid);
                        return Text(
                          _chessBoardController.getSan()[index]!,
                          style: TextStyle(color: Colors.white),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
