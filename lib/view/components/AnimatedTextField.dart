import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task_manager/theme/app_colors.dart';

class AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final double maxHeight;
  final double minHeight;
  final ValueChanged<String>? onChanged;
  final InputDecoration decoration;
  final TextStyle hintTextStyle;

  const AnimatedTextField({super.key,
    required this.controller,
    this.maxHeight = 300.0,
    this.minHeight = 50.0,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.hintTextStyle = const TextStyle(
      color: Colors.grey, // Set the color to grey
    ),
  });

  @override
  _AnimatedTextFieldState createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  double _currentHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
        maxHeight: widget.maxHeight,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.purple, width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          textAlign: TextAlign.right,
          controller: widget.controller,
          maxLines: null, // Allows the TextField to expand freely
          onChanged: (text) {
            setState(() {
              _currentHeight = widget.controller.text.isEmpty
                  ? widget.minHeight
                  : min(widget.maxHeight, max(widget.minHeight, _currentHeight));
            });

            widget.onChanged?.call(text);
          },
          decoration: widget.decoration.copyWith(
            border: InputBorder.none,
            hintStyle: widget.hintTextStyle,
          ),
        ),
      ),
    );
  }
}

