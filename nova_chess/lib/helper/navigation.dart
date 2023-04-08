import 'package:flutter/material.dart';

class CustomNavigation{
  static Route createRoute(Widget nextScreen, String name, Object? arguments){
    return PageRouteBuilder(
      settings: RouteSettings(
        name: name,
        arguments: arguments
      ),
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}