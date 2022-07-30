import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final double fontSize;
  final FontWeight fontWeight;
  final String hint;
  final String label;
  final Color textColor;

  const CustomInput(
      {Key? key,
      this.controller,
      this.obscureText = false,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.hint = "",
      this.label = "",
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          labelStyle: GoogleFonts.nunito(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          border: const UnderlineInputBorder(borderSide: BorderSide()),
        ),
      ),
    );
  }
}
