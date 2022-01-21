//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/screens/signin_screen.dart';
import 'package:yes_baby/screens/signUp/signup_screen.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';

class SelectAuthScreen extends StatefulWidget {
  const SelectAuthScreen({Key? key}) : super(key: key);

  @override
  _SelectAuthScreenState createState() => _SelectAuthScreenState();
}

class _SelectAuthScreenState extends State<SelectAuthScreen> {
  final AuthController authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          decoration: decoration(),
          width: width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height(context) * 0.14),
              Image(
                height: height(context) * 0.235,
                image: AssetImage('images/appLogo.png'),
              ),
              SizedBox(height: height(context) * 0.08),
              submitButton(
                context,
                text: 'Sign up',
                buttonColor: Color(0xff587391),
                textColor: Colors.white,
                onTap: () {
                  Get.to(() => SignupScreen(newUser: true));
                },
              ),
              SizedBox(height: 10),
              submitButton(
                context,
                text: 'Sign in',
                textColor: Color(0xff587391),
                buttonColor: Colors.white,
                onTap: () {
                  Get.to(() => SigninScreen());
                },
              ),
              SizedBox(height: 20),
              Image(
                image: AssetImage('images/baby.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
