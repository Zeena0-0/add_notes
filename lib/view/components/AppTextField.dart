import 'package:flutter/material.dart';



class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          textAlign: TextAlign.end,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black45),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
