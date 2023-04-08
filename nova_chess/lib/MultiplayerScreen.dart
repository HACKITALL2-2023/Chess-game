import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';

import 'custom_widgets/custom_app_bar.dart';

class MultiplayerScreen extends StatefulWidget {
  @override
  State<MultiplayerScreen> createState() => _MultiplayerScreenState();
}

class _MultiplayerScreenState extends State<MultiplayerScreen> {
  late double width;
  late double height;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ChessBoardController _chessBoardController = ChessBoardController();

  @override
  void initState() {
    super.initState();
    _chessBoardController.addListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
          showAppbar: false,
          scaffoldKey: scaffoldKey,
          width: width,
          height: height
      ),
      body: BackgroundLevelWidget(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2
              ),
              ChessBoard(
                controller: _chessBoardController,
                boardColor: BoardColor.darkBrown,
                boardOrientation: PlayerColor.white,
                onMove: () {},
                arrows: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
