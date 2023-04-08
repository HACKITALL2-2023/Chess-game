import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget{
  final Widget child;
  final double width;
  final double height;

  const BackgroundWidget({
    super.key, 
    required this.child, 
    required this.height, 
    required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover
          )  
        ),
        child: child,
    );
  }
}

class BackgroundWidgetAdventureMode extends StatelessWidget{
  final Widget child;
  final double width;
  final double height;

  const BackgroundWidgetAdventureMode({
    super.key, 
    required this.child, 
    required this.height, 
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_adventure.png'),
            fit: BoxFit.cover
          )  
        ),
        child: child,
    );
  }
}

class BackgroundLevelWidget extends StatelessWidget{
  final Widget child;
  final double width;
  final double height;

  const BackgroundLevelWidget({
    super.key, 
    required this.child, 
    required this.height, 
    required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_level.png'),
            fit: BoxFit.cover
          )  
        ),
        child: child,
    );
  }
}
