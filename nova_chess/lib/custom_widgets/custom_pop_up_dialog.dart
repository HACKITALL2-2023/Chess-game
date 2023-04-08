import 'dart:convert';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/custom_button_blue.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';
import 'package:nova_chess/scrollable_map_world.dart';

import '../helper/navigation.dart';
import '../level.dart';

class ConfirmEmailPopUpDialog extends StatelessWidget{
  final double width;
  final void Function() onPressed;

  const ConfirmEmailPopUpDialog({
    super.key,
    required this.width,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: const Color.fromARGB(255, 31, 25, 73),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: CustomTextWidgetWhite(
              text: 'Verify your account',
              textSize: 24,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/email_confirm.gif',
                width: 48,
                height: 48,
              ),
            ),
          ),
        ],       
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.15),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextWidgetWhite(
              text: 'Account activation link has been sent to the e-mail address you provided',
              textSize: 10,
              textAlign: TextAlign.center,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CustomTextWidgetWhite(
                  text: 'Didn’t get the mail?',
                  textSize: 8,
                ),
                SizedBox(
                  width: 7,
                ),
                CustomTextWidgetBlue(
                  text: 'Send it again',
                  textSize: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButtonBlue(
              width: 55,
              height: 22,
              text: 'OK',
              textSize: 11,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class TermsAndConditionsPopUp extends StatelessWidget{
  final double width;
  final double height;
  final void Function() onPressed;
  ScrollController _singleChildScrollController = ScrollController();
  ScrollController _scrollBarScrollController = ScrollController();

  TermsAndConditionsPopUp({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed
  });



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: const Color.fromARGB(255, 31, 25, 73),
      title: Container(
        alignment: Alignment.center,
        child: const CustomTextWidgetWhite(
          text: 'Terms & Conditions',
          textSize: 24,
        ),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: width * 0.083,
        vertical: height * 0.11,
      ),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255))
        ),
        child: CupertinoScrollbar(
          thumbVisibility: true,
          thickness: 7,
          controller: _singleChildScrollController,
          child: SingleChildScrollView(
            controller: _singleChildScrollController,
            child: Container(
              padding: const EdgeInsets.fromLTRB(13, 17, 15, 19),
              child: const CustomTextWidgetWhite(
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis eleifend quam adipiscing vitae proin sagittis nisl. Sagittis eu volutpat odio facilisis mauris. Aliquam eleifend mi in nulla posuere sollicitudin. Tincidunt lobortis feugiat vivamus at augue eget arcu. Quisque egestas diam in arcu cursus euismod quis. Felis bibendum ut tristique et egestas quis ipsum suspendisse. Auctor neque vitae tempus quam pellentesque nec nam aliquam sem. Amet dictum sit amet justo donec enim. Non sodales neque sodales ut etiam sit amet. Facilisi cras fermentum odio eu. Tincidunt praesent semper feugiat nibh sed pulvinar proin gravida hendrerit. Vitae aliquet nec ullamcorper sit amet risus nullam. Elit ut aliquam purus sit amet luctus venenatis lectus magna. Adipiscing commodo elit at imperdiet dui accumsan. Mattis vulputate enim nulla aliquet. Nibh sed pulvinar proin gravida hendrerit. Urna et pharetra pharetra massa massa ultricies mi quis hendrerit. Sed arcu non odio euismod lacinia at quis. Egestas dui id ornare arcu odio ut sem nulla. Sed egestas egestas fringilla phasellus faucibus. Sed tempus urna et pharetra pharetra. Lectus urna duis convallis convallis tellus id interdum. Etiam sit amet nisl purus in mollis nunc sed id. Neque aliquam vestibulum morbi blandit cursus risus at. Nunc mattis enim ut tellus. ',
                textSize: 14,
                fontFamily: 'Sarabun',
              ),
            ),
          )
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButtonBlue(
          width: 94,
          height: 38,
          text: 'CANCEL',
          textSize: 16,
          fontFamily: 'Sarabun',
          fontWeight: FontWeight.w600,
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class SelectLevelPopUp extends StatelessWidget{
  final double width;
  final double height;
  final bool nextLevel;

  const SelectLevelPopUp({
    super.key,
    required this.width,
    required this.height,
    required this.nextLevel
  });
  
  String _generateTitle(){
    if(nextLevel){
      return 'Level 6';
    }

    return 'Level 5';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: height * 0.32,
        width: width * 0.583,
        color: Colors.transparent,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.583,
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 31, 25, 73),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidgetWhite(
                        text: _generateTitle(),
                        textSize: 24
                      ),
                      SizedBox(
                        height: height * 0.016,
                      ),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => const VideoPlayerDialog(),
                        ),
                        child: Image.asset('assets/video_selected_level.png'),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomButtonBlue(
                        width: width * 0.2,
                        height: height * 0.03,
                        text: 'Start',
                        textSize: 16,
                        onPressed: () => {
                          // Navigator.of(context).push(CustomNavigation.createRoute(const Level()))
                        },
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset('assets/empty_left_star.png'),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Image.asset('assets/empty_center_star.png'),
                SizedBox(
                  width: width * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset('assets/empty_right_star.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessfulPopUp extends StatelessWidget{
  final double width;
  final double height;

  const SuccessfulPopUp({
    super.key,
    required this.width,
    required this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: height * 0.17,
        width: width * 0.586,
        color: Colors.transparent,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.583,
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 31, 25, 73),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidgetWhite(
                        text: 'Good job!',
                        textSize: 24
                      ),
                      const CustomTextWidgetWhite(
                        text: 'Level 5',
                        textSize: 16
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButtonBlue(
                            width: width * 0.18,
                            height: height * 0.029,
                            text: 'Retry',
                            textSize: 15,
                            onPressed: () => {
                              // Navigator.of(context).push(CustomNavigation.createRoute(const Level()))
                            },
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w600,
                          ),
                          CustomButtonBlue(
                            width: width * 0.18,
                            height: height * 0.029,
                            text: 'Next',
                            textSize: 15,
                            onPressed: () => {
                              // Navigator.of(context).push(CustomNavigation.createRoute(ScrollableMapWorld(nextLevel: true, width: width, height: height,)))
                            },
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset('assets/full_left_star.png'),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Image.asset('assets/full_center_star.png'),
                SizedBox(
                  width: width * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset('assets/empty_right_star.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerDialog extends StatefulWidget{
  const VideoPlayerDialog({super.key});
  
  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog>{
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
        enterFullscreenOnStart: true,
        exitFullscreenOnEnd: true,
      );
  
  @override
  void initState(){
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/queen_short.mp4')..initialize().then((value) => setState((){}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: const Color.fromARGB(255, 190, 98, 186),
      child: Container(
        alignment: Alignment.center,
        height: height * 0.17,
        width: width * 0.586,
        child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController,
        ),
      ),
    );
  }

}
