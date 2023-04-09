import 'package:flutter/cupertino.dart';

class Game {
  final Key id;
  final String username;
  final int noMoves;
  final String moves;
  final String date;
  final String result;

  Game(
      {required this.id,
      required this.username,
      required this.noMoves,
      required this.moves,
      required this.date,
      required this.result});
}
