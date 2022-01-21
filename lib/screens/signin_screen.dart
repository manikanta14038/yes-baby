//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/widgets.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/textfield.dart';
import 'forgotpassword_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder(
              init: AuthController(),
              builder: (_) => Container(
                height: height(context),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: decoration(),
                width: width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    appbar(text: 'Sign In'),
                    SizedBox(height: height(context) * 0.04),
                    Image(
                      height: height(context) * 0.235,
                      image: AssetImage('images/appLogo.png'),
                    ),
                    SizedBox(height: height(context) * 0.08),
                    loginField(
                      context,
                      text: 'Email',
                      icon: 'email',
                      controller: authController.email,
                      onSubmit: (v) {
                        authController.passwordNode.requestFocus();
                      },
                    ),
                    loginField(
                      context,
                      text: 'Password',
                      icon: 'lock',
                      controller: authController.password,
                      focusNode: authController.passwordNode,
                      obscureText: authController.hidePassword,
                      obscureTap: authController.obscurePassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: authController.selectStaySigned,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Color(0xffD2A776),
                                    ),
                                  ),
                                  child: authController.staySignnedIn
                                      ? Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Color(0xff587391),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Stay Logged In',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Color(0xff212121),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ForgotPasswordScreen());
                            },
                            child: Text(
                              'Forgot Your Password?',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Color(0xff212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    submitButton(
                      context,
                      text: 'Sign in',
                      buttonColor: Color(0xff587391),
                      textColor: Colors.white,
                      onTap: () {
                        authController.signInUser();
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      '------------ Or sign in with ------------',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        authButton(image: 'google'),
                        authButton(image: 'facebook'),
                        authButton(image: 'apple'),
                      ],
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

  authButton({required String image}) {
    return Container(
      height: height(context) * 0.055,
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: width(context) * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff0792EF).withOpacity(0.5),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Image(
          height: 20,
          image: AssetImage('images/$image.png'),
        ),
      ),
    );
  }
}
