//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/utils/screen_size.dart';

textCol({heading, text}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        heading,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 10),
      Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 10,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

imagetextCol(context, {heading, text, image}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Container(
      //   margin: EdgeInsets.symmetric(vertical: 20),
      //   height: height(context) * 0.27,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       fit: BoxFit.fill,
      //       image: CachedNetworkImageProvider(image),
      //     ),
      //   ),
      // ),
      Text(
        heading,
        style: GoogleFonts.montserrat(
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 10),
      Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.9),
        ),
      ),
    ],
  );
}

homeColContainer(context, {heading, image, text, value, onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        heading,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: height(context) * 0.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: width(context) * 0.31,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 9),
                Text(
                  text,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: height(context) * 0.09,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: width(context) * 0.5,
                        child: Text(
                          value,
                          style: GoogleFonts.montserrat(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 6,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: onTap,
                          child: Container(
                            height: 15,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffD2A776),
                            ),
                            child: Center(
                              child: Text(
                                'More',
                                style: GoogleFonts.montserrat(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

daysContainer(context, {text, number, power}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      height: height(context) * 0.07,
      decoration: BoxDecoration(
        color: Color(0xff587391),
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number,
                    style: GoogleFonts.montserrat(
                      height: 1,
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    power ?? 'th',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                text,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  height: 0.9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ],
      ),
    ),
  );
}

timerClock(context, {month, week, day, required bool small}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: small ? width(context) * 0.2 : width(context) * 0.14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        timeBlock(context, small, 'MONTH', month),
        timeBlock(context, small, 'WEEK', week),
        timeBlock(context, small, 'DAY', day),
      ],
    ),
  );
}

timeBlock(context, small, text, value) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            height: small ? height(context) * 0.09 : height(context) * 0.11,
            width: small ? width(context) * 0.14 : width(context) * 0.18,
            color: Color(0xff587391),
            alignment: Alignment.center,
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xffD2A776),
                fontSize: small ? 42 : 54,
              ),
            ),
          ),
          Positioned(
            top: small ? height(context) * 0.04 : height(context) * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff3D3D3D),
                        Color(0xffFFFFFF),
                        Color(0xff444444),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: small ? width(context) * 0.1 : width(context) * 0.14,
                  height: 1,
                  color: Colors.white,
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff3D3D3D),
                        Color(0xffFFFFFF),
                        Color(0xff444444),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Text(
        text,
        style: TextStyle(),
      ),
    ],
  );
}
