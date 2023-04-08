import 'package:flutter/material.dart';

class BoardSquare extends StatelessWidget{
  final double size;
  final bool hasQueen;
  final bool isBlack;
  final bool? goodSelection;
  final bool isSelectable;
  final BuildContext context;
  final Function? onPressed;
  final int position;
  final bool isGreen;
  final bool isRed;

  const BoardSquare({
    super.key,
    required this.context,
    required this.size,
    required this.hasQueen,
    required this.isBlack,
    required this.isSelectable,
    required this.position,
    required this.isGreen,
    required this.isRed,
    this.onPressed,
    this.goodSelection,
  });

  void pressed(){
    if(isSelectable){
      onPressed!(position);
    }
  }

  Color squareColor(){
    if (isGreen){
      return const Color.fromARGB(255, 137, 252, 127);
    }

    if(isRed){
      return const Color.fromARGB(255, 255, 97, 97);
    }

    if(isSelectable){
      return const Color.fromARGB(255, 155, 204, 253);
    }

    return isBlack ? Colors.transparent : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: squareColor(),
      child: GestureDetector(
        onTap: pressed,
        child: hasQueen ? Image.asset('assets/queen_pown.png') : Container()
      ),
    );
  }

}