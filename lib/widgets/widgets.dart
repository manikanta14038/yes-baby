//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables

// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/homecontroller.dart';
import 'package:yes_baby/screens/drawer/aboutUsScreen.dart';
import 'package:yes_baby/screens/drawer/contactUsScreen.dart';
import 'package:yes_baby/screens/drawer/privacyPolicyScreen.dart';
import 'package:yes_baby/screens/homescreen.dart';
import 'package:yes_baby/screens/notificationScreen.dart';
import 'package:yes_baby/screens/select_auth_screen.dart';
import 'package:yes_baby/screens/signUp/signup_screen.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/user_data.dart';

import 'dialogs.dart';

final HomeController homeController = Get.find<HomeController>();

appbar({required text, Function()? onTap}) {
  return Row(
    children: [
      InkWell(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
      SizedBox(width: 20),
      Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

bottomNav(context) {
  return Container(
    color: Color(0xff587391),
    padding: EdgeInsets.symmetric(horizontal: 30),
    height: height(context) * 0.09,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => SignupScreen(newUser: false));
          },
          child: Image(
            height: 22,
            image: AssetImage('images/personfill.png'),
          ),
        ),
        InkWell(
          onTap: () {
            Get.offUntil(
              MaterialPageRoute(builder: (ctx) => HomeScreen()),
              (route) => false,
            );
          },
          child: Image(
            height: 25,
            fit: BoxFit.fill,
            image: AssetImage('images/bird.png'),
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => NotificationScreen());
          },
          child: GetBuilder(
            init: HomeController(),
            builder: (_) => Stack(
              children: [
                Image(
                  height: 22,
                  image: AssetImage('images/bell.png'),
                ),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: homeController.notificationReceived ? 4 : 0,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

drawer(context) {
  return SafeArea(
    child: Drawer(
      child: Container(
        height: height(context),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder(
          init: HomeController(),
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height(context) * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   radius: width(context) * 0.08,
                  //   backgroundImage: AssetImage('images/pic.png'),
                  // ),
                  homeController.profileDetails['image'] == null
                      ? CircleAvatar(
                          radius: width(context) * 0.08,
                        )
                      : CircleAvatar(
                          radius: width(context) * 0.08,
                          backgroundImage: CachedNetworkImageProvider(
                              homeController.profileDetails['image']),
                        ),
                  SizedBox(width: 5),
                  Text(
                    homeController.userDetails['name'] ?? '',
                    style: GoogleFonts.montserrat(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height(context) * 0.07),
              drawerRow(
                context,
                text: 'Profile',
                onTap: () {
                  Get.back();
                  Get.to(() => SignupScreen(newUser: false));
                },
              ),
              drawerRow(
                context,
                text: 'About us',
                onTap: () {
                  Get.back();
                  Get.to(() => AboutUsScreen());
                },
              ),
              drawerRow(
                context,
                text: 'Privacy policy',
                onTap: () {
                  Get.back();
                  Get.to(() => PrivacyPolicyScreen());
                },
              ),
              drawerRow(
                context,
                text: 'Contact us',
                onTap: () {
                  Get.back();
                  Get.to(() => ContactUsScreen());
                },
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  yesNoDialog(
                    context,
                    text: 'Do you want to logout?',
                    onTap: () async {
                      await UserData().setUserId('');
                      await UserData().setStayLoggedIn(value: false);
                      Get.offUntil(
                        MaterialPageRoute(
                          builder: (context) => SelectAuthScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 20,
                      color: Color(0xffD2A776),
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.black.withOpacity(0.56),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}

drawerRow(context, {text, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: width(context) * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 20,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xffD2A776),
          ),
        ],
      ),
    ),
  );
}
