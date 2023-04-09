import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:nova_chess/helper/Game.dart';
import 'package:nova_chess/helper/routes.dart';
import 'custom_widgets/custom_app_bar.dart';

class ReplayScreen extends StatefulWidget {

  late Game moves;

  @override
  State<ReplayScreen> createState() => _ReplayScreenState();
}

class _ReplayScreenState extends State<ReplayScreen> {
  late double width;
  late double height;
  List<String> movesConsumed = [];
  List<String> moves = [];
  int step = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();


  final ChessBoardController _chessBoardController = ChessBoardController();

  void _goForward() {
    setState(() {
      if (moves.isNotEmpty) {
        step++;
        if (step % 2 == 1) {
          for (int i = 0; i < 2; i++){
            var currentMove = moves.first;
            print(currentMove);
            movesConsumed.add(currentMove);
            moves.remove(currentMove);
          }
        } else {
          for (int i = 0; i < 1; i++){
            var currentMove = moves.first;
            print(currentMove);
            movesConsumed.add(currentMove);
            moves.remove(currentMove);
          }
        }
        String controllerSet = movesConsumed.fold('', (previousValue, element) => previousValue + ' ' + element);
        print (controllerSet);
        _chessBoardController.loadPGN(controllerSet);
      }
    });
  }

  void _goBackword() {
    setState(() {
      print(movesConsumed.length);
      if (movesConsumed.isNotEmpty) {
        step--;
        if (step % 2 == 1) {
          for (int i = 0; i < 2; i++) {
            var currentMove = movesConsumed.removeLast();
            print(currentMove);
            moves.insert(0, currentMove);
          }
        } else {
          for (int i = 0; i < 1; i++) {
            var currentMove = movesConsumed.removeLast();
            print(currentMove);
            moves.insert(0, currentMove);
          }
        }
        String controllerSet = movesConsumed.fold('', (previousValue, element) => previousValue + ' ' + element);
        _chessBoardController.loadPGN(controllerSet);
      }
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

    widget.moves = ModalRoute.of(context)!.settings.arguments as Game;
    if (moves.isEmpty) {
      moves = widget.moves.moves.split(' ');
      moves.remove(moves[0]);
      print(moves);
    }

    return Scaffold(
      appBar: CustomAppBar(
          showAppbar: false,
          scaffoldKey: scaffoldKey,
          width: width,
          height: height),
      body: BackgroundLevelWidget(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.2 * height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.moves.result, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15),),
                    Text("Opponent: ${widget.moves.username}", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15),)
                  ],
                ),
              ),
              ChessBoard(
                controller: _chessBoardController,
                boardColor: BoardColor.darkBrown,
                boardOrientation: PlayerColor.white,
                // size: width * 0.4,
                enableUserMoves: false,
                onMove: () {
                  setState(() {});
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
                  child: Row(
                    children: [
                      Container(
                        width: 0.30 * width,
                        child: ListView.builder(
                            itemCount: _chessBoardController.getSan().length,
                            itemBuilder: (BuildContext ctx, int index) {
                              print(_chessBoardController.getSan().length);
                              return Text(
                                _chessBoardController.getSan()[index]!,
                                style: TextStyle(color: Colors.white),
                              );
                            }),
                      ),
                      Container(
                        width: 0.39 * width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed: () {
                              _goBackword();
                            }, icon: Icon(Icons.arrow_back_ios_new)),
                            IconButton(onPressed: () {
                              _goForward();
                            }, icon: Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
