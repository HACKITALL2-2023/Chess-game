import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final BuildContext context;
  final double width;
  final double height;
  final TextEditingController textEditingController;
  final void Function(BuildContext context) onEditingComplete;
  final void Function()? onTap;
  final String? hintText;
  final bool errorBorder;

  
  const CustomTextField({
    super.key,
    required this.context,
    required this.width,
    required this.height,
    required this.textEditingController,
    required this.onEditingComplete,
    required this.errorBorder,
    this.hintText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: width * 0.78,
            child: TextField(
              onTap: onTap,
              style: const TextStyle(
                  fontFamily: 'Alata',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 19, 10, 53),
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.97),
                  borderSide: BorderSide(
                    color: (!errorBorder) ? const Color.fromARGB(255, 52, 52, 52) : const Color.fromARGB(255, 214, 57, 57),
                    width: (!errorBorder) ? 0.71 : 2.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.97),
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                  ),
                ),
                hintStyle: const TextStyle(
                  fontFamily: 'Alata',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(145, 45, 45, 45),
                ),
                contentPadding: EdgeInsets.fromLTRB(width * 0.04, height * 0.01, 0, height * 0.01),
                hintText: hintText,
                // hintTextDirection: ,
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
              ),
              controller: textEditingController,
              onEditingComplete: () => onEditingComplete(context),
              cursorColor: const Color(0x00000000),
              autocorrect: false,
              enableSuggestions: false,
            ),
    );
  }
}
