import 'package:flutter/material.dart';

// ignore: camel_case_types
class Custom_Textformfield extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function(String? val) onSaved;

  const Custom_Textformfield({
    Key? key,
    this.hint = '',
    this.icon = Icons.format_italic_rounded,
    required this.onSaved,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
      onSaved: (value) => onSaved(value),
    );
  }
}
