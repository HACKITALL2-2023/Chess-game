import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';

import 'custom_widgets/custom_app_bar.dart';
import 'custom_widgets/custom_pop_up_dialog.dart';

class ScrollableMapWorld extends StatefulWidget{
  final bool nextLevel;
  final double width;
  final double height;

  
  const ScrollableMapWorld({
    super.key,
    nextLevel,
    width,
    height,
  }):
    nextLevel = nextLevel ?? false,
    width = width ?? 0,
    height = height ?? 0;

  @override
  State<ScrollableMapWorld> createState() => _ScrollableMapWorldState();
}

class _ScrollableMapWorldState extends State<ScrollableMapWorld>{
  final ScrollController _scrollViewController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 22);

    @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(minutes: 22));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void _selectGame(width, height) async {
      showDialog(
        context: context,
        builder: (context) => SelectLevelPopUp(
          width: width,
          height: height,
          nextLevel: widget.nextLevel,
        ),
      );
  }

  @override
  void dispose(){
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 19, 10, 51),
      appBar: CustomAppBarAdventure(
        showAppbar: true,
        scaffoldKey: scaffoldKey,
        width: width,
        height: height,
        lifes: 4,
        myDuration: myDuration,
      ),
      body: SingleChildScrollView(
        child: BackgroundWidgetAdventureMode(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                // onTap:() => _selectGame(width, height),
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  height: height * 0.85,
                  child: !widget.nextLevel ? Image.asset('assets/levels.png') : Image.asset('assets/levels6.png'),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Expanded(
                child: Container(
                  width: width,
                  height: height * 0.13,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: width * 0.15,
                        height: width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(25, 144, 162, 255),
                        ),
                        child: Image.asset('assets/knight.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextWidgetWhite(
                            text: 'Catalina',
                            textSize: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CustomTextWidgetWhite(
                                text: 'Rank: ',
                                textSize: 13,
                                fontFamily: 'Sarabun',
                                fontWeight: FontWeight.w700,
                              ),
                              CustomTextWidgetWhite(
                                text: 'Pawn',
                                textSize: 12,
                                fontFamily: 'Sarabun',
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextWidgetWhite(
                            text: 'Chapter 1 - Basics',
                            textSize: 15,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: height * 0.013,
                          ),
                          LinearPercentIndicator(
                            width: width * 0.46,
                            lineHeight: height * 0.034,
                            percent: 0.25,
                            backgroundColor: const Color.fromARGB(74, 64, 65, 126),
                            progressColor: const Color.fromARGB(74, 87, 93, 164),
                            barRadius: const Radius.circular(10),
                            center: CustomTextWidgetWhite(
                              text: !widget.nextLevel ? '25%' : '30%',
                              textSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}