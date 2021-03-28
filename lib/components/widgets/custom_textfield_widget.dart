import 'package:flutter/material.dart';

class Custom_TextField extends StatelessWidget {
  final Function(String? val) onChanged;
  final labelText;
  final controller;
  final sc_controller;
  const Custom_TextField({
    Key? key,
    required this.onChanged,
    this.labelText,
    this.controller,
    this.sc_controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: labelText,
        contentPadding: EdgeInsets.only(left: 10),
      ),
      scrollController: sc_controller,
      onChanged: (value) => onChanged(value),
    );
  }
}
