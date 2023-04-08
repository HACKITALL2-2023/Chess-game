import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double width;
  final double height;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool showAppbar;

  const CustomAppBar({
    super.key,
    required this.width,
    required this.height,
    required this.scaffoldKey,
    required this.showAppbar,
  });

  void _drawerOnPressed(){
    if(scaffoldKey.currentState!.isEndDrawerOpen){
          scaffoldKey.currentState!.closeEndDrawer();
    }else{
          scaffoldKey.currentState!.openEndDrawer();
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height * 0.15);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: showAppbar ? preferredSize : Size.zero,
      child: Container(
        height: showAppbar ? height * 0.15 : 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(255, 19, 10, 51),
              elevation: 0,
              title: Container(
                margin: EdgeInsets.fromLTRB(width * 0.08, 0, 0, 0),
                child: Image.asset('assets/logo_home.png'),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, width * 0.08, 0),
                  child: IconButton(
                    color: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    alignment: Alignment.center,
                    onPressed: _drawerOnPressed,
                    icon: Image.asset(
                      'assets/hamburger_menu.png',
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class CustomAppBarAdventure extends StatelessWidget implements PreferredSizeWidget{
  final double width;
  final double height;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool showAppbar;
  final int lifes;
  final Duration myDuration;

  const CustomAppBarAdventure({
    super.key,
    required this.width,
    required this.height,
    required this.scaffoldKey,
    required this.showAppbar,
    required this.lifes,
    required this.myDuration
  });

  Image _generateLife(int index){
    if(index <= lifes){
      return Image.asset('assets/full_heart.png');
    }

    return Image.asset('assets/empty_heart.png');
  }

  void _drawerOnPressed(){
    if(scaffoldKey.currentState!.isEndDrawerOpen){
          scaffoldKey.currentState!.closeEndDrawer();
    }else{
          scaffoldKey.currentState!.openEndDrawer();
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height * 0.15);

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return PreferredSize(
      preferredSize: showAppbar ? preferredSize : Size.zero,
      child: Container(
        height: showAppbar ? height * 0.15 : 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(255, 19, 10, 51),
              elevation: 0,
              title: Container(
                margin: EdgeInsets.fromLTRB(width * 0.08, 0, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        for(int i = 1; i <= 5; i++)
                          _generateLife(i)
                      ],
                    ),
                    Row(
                        children: [
                          CustomTextWidgetWhite(
                          text: 'Next life in $minutes:$seconds',
                          textSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, width * 0.08, 0),
                  child: IconButton(
                    color: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    alignment: Alignment.center,
                    onPressed: _drawerOnPressed,
                    icon: Image.asset(
                      'assets/hamburger_menu.png',
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
