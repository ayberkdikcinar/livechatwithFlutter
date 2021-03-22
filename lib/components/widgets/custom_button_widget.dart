import 'package:flutter/material.dart';

// ignore: camel_case_types
class Custom_Button extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  const Custom_Button({
    Key? key,
    this.title = '',
    this.color = Colors.blue,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: color),
        onPressed: () {
          onPressed();
        },
        child: Text(title, style: TextStyle(color: Colors.white)));
  }
}
