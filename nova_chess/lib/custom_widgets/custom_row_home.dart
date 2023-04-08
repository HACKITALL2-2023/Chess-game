import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';

class CustomRowHome extends StatelessWidget{
  final double width;
  final double height;
  final Image imageButton;
  final String buttonText;
  final void Function()? onPressed;

  const CustomRowHome({
    super.key,
    required this.width,
    required this.height,
    required this.imageButton,
    required this.buttonText,
    required this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
      return  GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.035),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(width * 0.03, width * 0.03, width * 0.03, width * 0.03),
                width: width * 0.14,
                height: width * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.76),
                  color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03),
                ),
                child: imageButton
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.58,
                height: width * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.76),
                  color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03),
                ),
                child: CustomTextWidgetWhite(
                  text: buttonText,
                  textSize: 16
                ),
              ),
            ],
          ),
        ),
      );
  }
}
