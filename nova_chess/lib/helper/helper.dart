import 'package:flutter/material.dart';

class Helper{
  static void giveUpFocus(BuildContext context){
    FocusScope.of(context).unfocus();
  }
}