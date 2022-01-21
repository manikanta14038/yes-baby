//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/widgets.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({Key? key}) : super(key: key);

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final AuthController authController = Get.put(AuthController());

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
                    'OTP',
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'We have sent an OTP to your email',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Color(0xff454F63),
                    ),
                  ),
                  SizedBox(height: height(context) * 0.02),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.14),
                    child: PinInputTextField(
                      pinLength: 4,
                      controller: authController.forgotOtp,
                      decoration: BoxLooseDecoration(
                        gapSpace: 6,
                        bgColorBuilder:
                            PinListenColorBuilder(Colors.white, Colors.white),
                        strokeColorBuilder:
                            PinListenColorBuilder(Colors.white, Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  submitButton(
                    context,
                    text: 'Verify',
                    buttonColor: Color(0xff587391),
                    textColor: Colors.white,
                    onTap: authController.verifyOtp,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "I didn't receive an OTP!",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                  SizedBox(height: 7),
                  InkWell(
                    onTap: authController.resendOtpUser,
                    child: Text(
                      'Resend OTP',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff587391),
                      ),
                    ),
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
