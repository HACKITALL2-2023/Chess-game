import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:nova_chess/custom_widgets/custom_pop_up_dialog.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';
import 'package:nova_chess/helper/board_square.dart';

import 'custom_widgets/custom_app_bar.dart';

class Level extends StatefulWidget{
  const Level({super.key});
  
  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level>{
  final ScrollController _scrollViewController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List blueSquares = [7, 10, 19, 47, 53];
  final List possibleForQueen = [7, 10, 47];
  List isGreen = [];
  List isRed = [];
  int stateFlow = 0;
  final int queenPos = 42;

  bool isQueenSquare(i, j){
    return (i * 8 + j) == queenPos;
  }

  bool isSelectable(i, j){
    return blueSquares.contains(i * 8 + j);
  }

  bool isBlackSquare(i, j){
    if(i % 2 !=  0){
      return j % 2 == 0;
    } 
    return j % 2 != 0;
  }

  bool isGreenBox(i, j){
    return isGreen.contains(i * 8 + j);
  }

  bool isRedBox(i, j){
    return isRed.contains(i * 8 + j);
  }

  void _onPressedSquare(index, width, height){
    if (possibleForQueen.contains(index)){
      setState(() {
        isGreen.add(index);
        stateFlow++;
        if(stateFlow == 4){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SuccessfulPopUp(
              width: width,
              height: height
            ),
          );
        }
      });
    } else {
      setState(() {
        isRed.add(index);
        stateFlow++;
      });
    }
  }

  String _generateMessage(width, height){
    if(stateFlow == 0){
      return 'Try to remember what you’ve learned about moving the queen.';
    } else if(stateFlow == 1){
      return 'That’s great. Keep it going!';
    } else if(stateFlow == 2){
      return 'Uh oh! That square is not on the same row, column, or diagonal as the queen.';
    } else if(stateFlow == 3){
      return 'Yes, yes, yes!!!';
    } else if(stateFlow == 4){
      return 'Yes, yes, yes!!!';
    }

    return 'Yes, yes, yes!!!';
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 19, 10, 51),
        appBar: CustomAppBar(
        showAppbar: true,
        scaffoldKey: scaffoldKey,
        width: width,
        height: height
      ),
      endDrawer: Drawer(
        child: Container(),
      ),
      body: BackgroundLevelWidget(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(width * 0.13, 0, width * 0.13, 0),
                child: const CustomTextWidgetWhite(
                  text: 'Which one of the highlighted squares can the queen reach?',
                  textSize: 20
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.16),
                      border: Border.all(
                        width: 9.64,
                        color: Colors.black.withAlpha(97)
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 8; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for(int j = 0; j < 8; j++)
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all()
                                  ),
                                  child: GestureDetector(
                                      onTap: () => _onPressedSquare(i * 8 + j, width, height),
                                      child: BoardSquare(
                                      context: context,
                                      size: width * 0.087,
                                      hasQueen: isQueenSquare(i, j),
                                      isBlack: isBlackSquare(i, j),
                                      isSelectable: isSelectable(i, j),
                                      isGreen: isGreenBox(i, j),
                                      isRed: isRedBox(i, j),
                                      position: i * 8 + j,
                                      onPressed: _onPressedSquare,
                                    )
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.042,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.29,
                    height: height * 0.18,
                    child: Image.asset('assets/cal_meteorit.png'),
                  ),
                  Container(
                    width: width * 0.4,
                    child: CustomTextWidgetWhite(
                      text: _generateMessage(width, height),
                      textSize: 16,
                      fontFamily: 'Sarabun',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}