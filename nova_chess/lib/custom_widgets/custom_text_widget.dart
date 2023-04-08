import 'package:flutter/material.dart';

class CustomTextWidgetWhite extends StatelessWidget{
  final String text;
  final double textSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const CustomTextWidgetWhite({
    super.key,
    required this.text,
    required this.textSize,
    this.textAlign,
    fontWeight,
    fontFamily,
  }) : 
    fontWeight = fontWeight ?? FontWeight.w400,
    fontFamily = fontFamily ?? 'Alata';

  @override
  Widget build(BuildContext context) {
    return Text(
            text,
            textAlign: textAlign,
            style: TextStyle(
              fontFamily: fontFamily,
              fontStyle: FontStyle.normal,
              fontSize: textSize,
              fontWeight: fontWeight,
              color: const Color.fromARGB(255, 255, 255, 255)
            ),
          );
  }
}

class CustomTextWidgetBlue extends StatelessWidget{
  final String text;
  final double textSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const CustomTextWidgetBlue({
    super.key,
    required this.text,
    required this.textSize,
    this.textAlign,
    fontWeight,
    fontFamily,
  }):
    fontWeight = fontWeight ?? FontWeight.w400,
    fontFamily = fontFamily ?? 'Alata';

  @override
  Widget build(BuildContext context) {
    return Text(
            text,
            textAlign: textAlign,
            style: TextStyle(
              fontFamily: fontFamily,
              fontStyle: FontStyle.normal,
              fontSize: textSize,
              fontWeight: fontWeight,
              color: const Color.fromARGB(255, 113, 130, 215)
            ),
          );
  }
}

class CustomTextWidgetError extends StatelessWidget{
  final String text;
  final double textSize;
  final TextAlign? textAlign;

  const CustomTextWidgetError({
    super.key,
    required this.text,
    required this.textSize,
    this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(
            text,
            textAlign: textAlign,
            style: TextStyle(
                fontFamily: 'Sarabun',
                fontStyle: FontStyle.normal,
                fontSize: textSize,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 214, 57, 57)
            ),
          );
  }
}