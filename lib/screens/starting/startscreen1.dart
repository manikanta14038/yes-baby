//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/screens/starting/startscreen2.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/decoration.dart';

class Startscreen1 extends StatefulWidget {
  const Startscreen1({Key? key}) : super(key: key);

  @override
  _Startscreen1State createState() => _Startscreen1State();
}

class _Startscreen1State extends State<Startscreen1> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/mom1.png'),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: height(context) * 0.16),
              Container(
                height: height(context) * 0.64,
                width: width(context),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xff204A7A).withOpacity(0.47),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.47),
                    width: 9,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: height(context) * 0.15,
                      image: AssetImage('images/logo.png'),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "That is fantastic news. Congratulations.. You're going to be a mom. The most beautiful time in your life. This app will assist you in strengthening your mind and soul in order to have a physically and mentally healthy baby. It will also show you how to smooth out the period when you are experiencing a lot of mood swings.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        // fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        // fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height(context) * 0.045),
              InkWell(
                onTap: (){
                  Get.to(()=>Startscreen2());
                },
                child: Container(
                  height: height(context) * 0.055,
                  width: width(context) * 0.42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: GoogleFonts.montserrat(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff587391),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
