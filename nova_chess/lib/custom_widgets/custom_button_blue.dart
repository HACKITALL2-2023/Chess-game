import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

class CustomButtonBlue extends StatelessWidget{
  final double width;
  final double height;
  final String text;
  final double textSize;
  final void Function()? onPressed;
  final bool? disabled;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const CustomButtonBlue({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.textSize,
    required this.onPressed,
    this.disabled,
    fontWeight,
    fontFamily
  }):
    fontWeight = fontWeight ?? FontWeight.w400,
    fontFamily = fontFamily ?? 'Alata';

  @override
  Widget build(BuildContext context) {
    return TextButton(
            style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)
                ),
            onPressed: onPressed,
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.37),
                color: const Color.fromARGB(255, 86, 100, 172)
              ),
              child: CustomTextWidgetWhite(
                text: text,
                textSize: textSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight,
              ),
            ),
          );
  }
  
}