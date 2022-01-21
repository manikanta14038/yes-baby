// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/widgets.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: decoration(),
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appbar(text: 'Contact us'),
              SizedBox(height: height(context) * 0.05),
              Image(
                height: height(context) * 0.18,
                image: AssetImage('images/appLogo.png'),
              ),
              SizedBox(height: height(context) * 0.05),
              Text(
                'Get in Touch',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'For further inquires please do contact us through our email below.',
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  launch('http:support@yesbaby.org');
                },
                child: Text(
                  'support@yesbaby.org',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 40,
                    image: AssetImage('images/fb.png'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 40,
                    image: AssetImage('images/youtube.png'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 40,
                    image: AssetImage('images/insta.png'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
