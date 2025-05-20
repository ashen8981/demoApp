import 'package:flutter/material.dart';
import '../core/utils/input_decorations.dart';

Widget buildTextField(
  String label,
  TextEditingController controller, {
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  bool obscureText = false,
  String? hintText,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: AppInputDecorations.field(
      hintText: hintText ?? label,
    ).copyWith(suffixIcon: suffixIcon),
    validator: validator ?? (val) => val!.isEmpty ? "Required" : null,
  );
}
