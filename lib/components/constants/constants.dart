import 'package:flutter/material.dart';

const color1 = Color.fromARGB(255, 255, 160, 122);
const color2 = Color.fromARGB(255, 255, 99, 71);
const textinputcolor = Color.fromARGB(150, 220, 153, 255);
double dynamicHeight(BuildContext context, double val) =>
    MediaQuery.of(context).size.height * val;
double dynamicWidth(BuildContext context, double val) =>
    MediaQuery.of(context).size.width * val;
Widget get emptySpace => SizedBox(height: 10);
