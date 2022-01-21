//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/screens/homescreen.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/cards.dart';
import 'package:yes_baby/widgets/decoration.dart';

class RegisterSubmitScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  RegisterSubmitScreen({required this.dueInfo});
  // ignore: prefer_typing_uninitialized_variables
  var dueInfo;

  @override
  _RegisterSubmitScreenState createState() => _RegisterSubmitScreenState();
}

class _RegisterSubmitScreenState extends State<RegisterSubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height(context),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: decoration(),
          width: width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height(context) * 0.15),
              Image(
                height: height(context) * 0.19,
                image: AssetImage('images/appLogo.png'),
              ),
              SizedBox(height: height(context) * 0.03),
              SizedBox(
                height: height(context) * 0.16,
                width: width(context),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      child: Container(
                        height: height(context) * 0.12,
                        width: width(context) * 0.78,
                        padding: EdgeInsets.only(right: 20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xff587391),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff0033A7).withOpacity(0.3),
                              blurRadius: 20,
                            ),
                          ],
                          image: DecorationImage(
                            alignment: Alignment.centerRight,
                            image: AssetImage('images/foot.png'),
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Your baby is due',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width(context) * 0.1,
                      child: Container(
                        width: width(context) * 0.24,
                        height: height(context) * 0.12,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            widget.dueInfo['due_date'],
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              height: 0.9,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffD2A776),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'You are currently',
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 17),
              timerClock(
                context,
                month: widget.dueInfo['month'].toString().padLeft(2, '0'),
                week: widget.dueInfo['week'].toString().padLeft(2, '0'),
                day: widget.dueInfo['day'].toString().padLeft(2, '0'),
                small: false,
              ),
              SizedBox(height: height(context) * 0.05),
              Align(
                alignment: Alignment.center,
                child: submitButton(
                  context,
                  text: 'Continue',
                  buttonColor: Color(0xff587391),
                  textColor: Colors.white,
                  onTap: () {
                    Get.offUntil(
                      MaterialPageRoute(builder: (ctx) => HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
