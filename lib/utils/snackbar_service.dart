
import 'package:flutter/material.dart';


class SnackBarService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
           message,style:TextStyle(color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,),

        ),duration: duration,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
        ),
      ),
    );
  }
}
