import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1, this.keyboardType = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: GlobalVariables.kPrimaryTextColor,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: GlobalVariables.kPrimaryTextColor,fontSize: 13,fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          hintText: hintText,
          filled: true,
          fillColor: GlobalVariables.kPrimaryColor,
          hintStyle: GoogleFonts.poppins(color: GlobalVariables.kPrimaryTextColor.withOpacity(0.5) ,fontSize: 13,fontWeight: FontWeight.w400),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
            color: Colors.black38,
          ),
          ),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
            color: GlobalVariables.kPrimaryTextColor,
          )),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: GlobalVariables.kPrimaryTextColor,width: 1.4
            )),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
