//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/screens/enterotp_screen.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/widgets.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height(context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: decoration(),
              width: width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  appbar(text: 'Forgot password'),
                  SizedBox(height: height(context) * 0.07),
                  Image(
                    height: height(context) * 0.19,
                    image: AssetImage('images/appLogo.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Forgot your password ?',
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Provide your registered email\nand check your inbox',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.04),
                  loginField(
                    context,
                    text: 'Email Address*',
                    icon: 'email',
                    controller: authController.email,
                  ),
                  SizedBox(height: 30),
                  submitButton(
                    context,
                    text: 'Submit',
                    buttonColor: Color(0xff587391),
                    textColor: Colors.white,
                    onTap: authController.forgotPassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
