// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;

  const MyInput({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
