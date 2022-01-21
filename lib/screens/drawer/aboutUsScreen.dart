// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/widgets.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: decoration(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              appbar(text: 'About Us'),
              SizedBox(height: height(context)*0.07),
              Center(
                child: Image(
                  height: height(context) * 0.18,
                  image: AssetImage('images/appLogo.png'),
                ),
              ),
              SizedBox(height: height(context)*0.04),
              Text(
                "About Yes Baby",
                style: GoogleFonts.poppins(
                  fontSize: 22  ,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height(context)*0.04),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
