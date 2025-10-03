



import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;// ✅ add validator
  final int? maxLength;

  const CustomInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.validator, // ✅
    this.maxLength
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChanged,
        validator: validator, // ✅ email validation works here
        maxLength: maxLength,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          counterText: '',
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}