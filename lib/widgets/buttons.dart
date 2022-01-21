import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/utils/screen_size.dart';

submitButton(context, {text, buttonColor, textColor, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height(context) * 0.055,
      width: width(context) * 0.46,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            // fontWeight: FontWeight.w500, 
            color: textColor,
          ),
        ),
      ),
    ),
  );
}
