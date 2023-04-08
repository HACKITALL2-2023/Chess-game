import 'package:flutter/material.dart';
import 'package:nova_chess/helper/navigation.dart';
import 'package:nova_chess/home_tournaments.dart';
import 'package:nova_chess/scrollable_map_world.dart';
import 'package:nova_chess/sign_in.dart';
import 'package:nova_chess/sign_up.dart';

import '../home.dart';

class OwnRouter {
    static const String signInRoute = '/';
    static const String signUpRoute = '/sign_up';
    static const String homeRoute = '/home';
    static const String tournamentsRoute = '/tournaments';
    static const String scrollableMapWorldRoute = '/scrollable_map_world';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case signInRoute:
        return CustomNavigation.createRoute(const SignIn(), signInRoute, null);
      case signUpRoute:
        return CustomNavigation.createRoute(const SignUp(), signUpRoute, null);
      case homeRoute:
        return CustomNavigation.createRoute(const HomeScreen(), homeRoute, settings.arguments);
      case tournamentsRoute:
        return CustomNavigation.createRoute(const HomeTournaments(), tournamentsRoute, null);
      case scrollableMapWorldRoute:
        return CustomNavigation.createRoute(const ScrollableMapWorld(), scrollableMapWorldRoute, null);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}