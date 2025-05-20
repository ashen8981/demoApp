import 'package:flutter/material.dart';

class AppInputDecorations {
  static InputDecoration standard({required String label}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color.fromARGB(255, 248, 248, 248),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 224, 217, 217)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 224, 217, 217)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 150, 150, 150)),
      ),
    );
  }

  static InputDecoration field({String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 248, 248, 248),
      hintText: hintText,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 224, 217, 217)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 224, 217, 217)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 150, 150, 150)),
      ),
    );
  }
}
