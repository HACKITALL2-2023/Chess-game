import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';

class LoggoMottoWidget extends StatelessWidget{
  final double width;
  final double height;

  const LoggoMottoWidget({
    super.key,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: width * 0.78,
            height: height * 0.34,
            margin: EdgeInsets.fromLTRB(0, height * 0.061, 0, 0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'assets/logo_sign_in.png',
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, 0),
                  child: const CustomTextWidgetWhite(
                    text: 'Boost your chess skills and shoot for the stars.',
                    textSize: 14,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
  }

}