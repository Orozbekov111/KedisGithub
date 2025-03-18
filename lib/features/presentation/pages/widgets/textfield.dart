import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode; 
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow:const  [
          BoxShadow(
            color: Colors.grey, // Shadow color
            spreadRadius: 0.2, // Spread radius
            blurRadius: 2, // Blur radius
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        focusNode: focusNode,
        onTap: onTap,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          filled: true,
          errorText: errorMsg,
          floatingLabelBehavior: FloatingLabelBehavior.auto, // Control floating behavior
          labelText: hintText, // Set label text to be the same as hint text
          labelStyle: TextStyle(color: Colors.grey[800]), // Style for label text
        ),
      ),
    );
  }
}