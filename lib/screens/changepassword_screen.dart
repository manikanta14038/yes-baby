//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/widgets.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
              child: GetBuilder(
                init: AuthController(),
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    appbar(text: 'Change Password'),
                    SizedBox(height: height(context) * 0.04),
                    Image(
                      height: height(context) * 0.19,
                      image: AssetImage('images/appLogo.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Create new Password',
                      style: GoogleFonts.montserrat(
                        fontSize: 29,
                      ),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    loginField(
                      context,
                      text: 'Password*',
                      icon: 'lock',
                      controller: authController.resetPassword,
                      obscureText: authController.resetPasswordHide,
                      obscureTap: authController.obscureResetPassword,
                      onSubmit: (v) {
                        authController.confirmPasswordNode.requestFocus();
                      },
                    ),
                    loginField(
                      context,
                      text: 'Confirm Password*',
                      icon: 'lock',
                      controller: authController.resetConfirmPassword,
                      focusNode: authController.confirmPasswordNode,
                      obscureText: authController.resetConfirmPasswordHide,
                      obscureTap: authController.obscureResetConfirmPassword,
                      onSubmit: (v) {
                        authController.confirmPasswordNode.unfocus();
                        authController.changeUserPassword(context);
                      },
                    ),
                    SizedBox(height: height(context) * 0.04),
                    submitButton(
                      context,
                      text: 'Reset password',
                      buttonColor: Color(0xff587391),
                      textColor: Colors.white,
                      onTap: () {
                        authController.changeUserPassword(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
