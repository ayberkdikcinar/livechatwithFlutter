import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class Custom_Textformfield extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function(String? val) onChanged;
  final Function(String? val) validator;
  final String label;
  final TextInputType type;
  final String initialText;
  const Custom_Textformfield({
    Key? key,
    this.hint = '',
    this.icon = Icons.edit,
    required this.onChanged,
    this.label = '',
    required this.validator,
    this.type = TextInputType.text,
    this.initialText = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hint,
          prefixIcon: Icon(icon),
          labelText: label,
          contentPadding: EdgeInsets.only(left: 20),
          counterText: ''),
      onChanged: (value) => onChanged(value),
      validator: (value) => validator(value),
      keyboardType: type,
      autofocus: false,
      initialValue: initialText,
      maxLength: type == TextInputType.phone ? 10 : 50,
      inputFormatters: [if (type == TextInputType.number || type == TextInputType.phone) FilteringTextInputFormatter.digitsOnly],
    );
  }
}
