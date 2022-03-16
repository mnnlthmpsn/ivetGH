import 'package:flutter/material.dart';
import 'package:vetgh/config.dart';

class KInput extends StatelessWidget {

  final String label;
  final void Function(String) onChanged;
  final TextEditingController controller;

  const KInput({Key? key, required this.label, required this.onChanged, required this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      cursorColor: KColors.kDarkColor,
      cursorWidth: .5,
      style: TextStyle(color: KColors.kDarkColor, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: const Icon(Icons.search),
        suffixIconColor: KColors.kDarkColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
