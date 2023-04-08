import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget{
  final void Function()? setValue;
  final bool checked;

  const CustomCheckBox({
      super.key,
      required this.setValue,
      required this.checked
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: setValue,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Row(
                  children: [
                    if(checked)
                      Image.asset(
                        'assets/thick.png',
                        width: 16,
                        height: 16,
                      )
                  ],
                )
              ),
            );
  }

}