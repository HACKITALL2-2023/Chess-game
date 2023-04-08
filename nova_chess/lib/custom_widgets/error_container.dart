import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

class ErrorContainer extends StatelessWidget{
  final double width;
  final double height;
  final bool shouldAppear;
  final String text;
  final double textSize;
  final MainAxisAlignment mainAxisAlignment;

  const ErrorContainer({
    super.key,
    required this.width,
    required this.height,
    required this.shouldAppear,
    required this.text,
    required this.textSize,
    required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: width * 0.78,
            height: (shouldAppear) ? height * 0.06 : height * 0.03,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                if(shouldAppear)
                  CustomTextWidgetError(
                    text: text,
                    textSize: textSize,
                  ),
              ],
            ),
          );
  }
}

class ErrorContainerMultilines extends StatelessWidget{
  final double width;
  final double height;
  final bool shouldAppear;
  final String text;
  final double textSize;
  final MainAxisAlignment mainAxisAlignment;

  const ErrorContainerMultilines ({
    super.key,
    required this.width,
    required this.height,
    required this.shouldAppear,
    required this.text,
    required this.textSize,
    required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    if (!shouldAppear) {
      return SizedBox(
        height: height * 0.03,
      );
    }

    return Container(
            width: width * 0.78,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                CustomTextWidgetError(
                    text: text,
                    textSize: textSize,
                  ),
              ],
            ),
          );
  }

}