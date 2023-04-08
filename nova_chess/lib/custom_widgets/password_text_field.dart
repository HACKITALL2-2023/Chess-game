import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget{
  final BuildContext context;
  final double width;
  final double height;
  final TextEditingController textEditingController;
  final void Function(BuildContext context) onEditingComplete;
  final void Function() showPassword;
  final void Function()? onTap;
  final bool showPasswordBool;
  final bool errorBorder;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.context,
    required this.width,
    required this.height,
    required this.textEditingController,
    required this.onEditingComplete,
    required this.showPassword,
    required this.showPasswordBool,
    required this.hintText,
    required this.errorBorder,
    this.onTap
  });
  
  Widget _showHidePasswordImage(showPasswordBool){
    if (!showPasswordBool){
      return Image.asset(
          'assets/show_icon.jpg',
          width: 15,
          height: 15,
        );
    }

    return Image.asset(
        'assets/hide_icon.png',
        width: 15,
        height: 15,
      );
  }

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
                suffixIcon: GestureDetector(
                  onTap: showPassword,
                  child: _showHidePasswordImage(showPasswordBool)
                ),
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
              autocorrect: false,
              obscureText: !showPasswordBool,
              controller: textEditingController,
              onEditingComplete: () => onEditingComplete(context),
              cursorColor: const Color(0x00000000),
              enableSuggestions: false,
            ),
    );
  }
}
