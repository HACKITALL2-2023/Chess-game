import 'package:flutter/material.dart';

import 'helper/Game.dart';
import 'helper/routes.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    required this.width,
    required this.height,
    required this.date,
    required this.noMoves,
    required this.username,
    required this.result,
    required this.key,
    required this.moves,
  });

  final Key key;
  final double width;
  final double height;
  final String date;
  final int noMoves;
  final String username;
  final String result;
  final String moves;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Container(
          // color: Colors.blue,
          height: 0.3 * height,
          width: width * 0.8,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color(0xFF758ECD).withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 0.05 * height,
                    width: width * 0.20,
                    child: Text(
                      result,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: result == "WIN" ? Colors.green : Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 0.05 * height,
                    width: width * 0.20,
                    child: Text(
                      'VS',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.05 * height,
                    width: width * 0.20,
                    child: Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text('Moves: $noMoves'),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 0.05 * height,
                    width: width * 0.20,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.05 * height,
                    width: width * 0.20,
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () => {
        Navigator.of(context).pushNamed(OwnRouter.replayRoute,
            arguments: Game(
                id: key,
                username: username,
                noMoves: noMoves,
                moves: moves,
                date: date,
                result: result,
            ))
      },
    );
  }
}
