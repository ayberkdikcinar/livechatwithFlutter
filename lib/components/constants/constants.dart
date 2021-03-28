import 'package:flutter/material.dart';

const color1 = Color.fromARGB(255, 255, 160, 122);
const color2 = Color.fromARGB(255, 255, 99, 71);
const colorSender = Color.fromARGB(130, 0, 102, 51);
const colorReceiver = Color.fromARGB(255, 64, 64, 64);
const textinputcolor = Color.fromARGB(150, 220, 153, 255);
double dynamicHeight(BuildContext context, double val) => MediaQuery.of(context).size.height * val;
double dynamicWidth(BuildContext context, double val) => MediaQuery.of(context).size.width * val;
Widget get emptySpaceHeight => SizedBox(height: 10);
Widget get emptySpaceWidth => SizedBox(width: 10);
SnackBar buildSnackBar({required String text, Color? bgColor, Color? textColor, int? second}) {
  return SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white),
      ),
      backgroundColor: bgColor ?? Colors.black,
      duration: Duration(seconds: second ?? 1));
}
