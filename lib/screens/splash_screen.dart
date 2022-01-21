//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yes_baby/screens/homescreen.dart';
import 'package:yes_baby/screens/select_auth_screen.dart';
import 'package:yes_baby/screens/starting/startscreen1.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/user_data.dart';
import 'package:yes_baby/widgets/decoration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      try {
        bool signnedId = await UserData().getStayLoggedIn();
        String userId = await UserData().getUserId();
        if (signnedId || userId.isNotEmpty) {
          Get.offUntil(
            MaterialPageRoute(builder: (ctx) => HomeScreen()),
            (route) => false,
          );
        } else {
          Get.offUntil(
            MaterialPageRoute(builder: (ctx) => SelectAuthScreen()),
            (route) => false,
          );
        }
      } catch (e) {
        Get.offUntil(
          MaterialPageRoute(builder: (ctx) => Startscreen1()),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: decoration(),
          child: Center(
            child: Image(
              height: height(context) * 0.3,
              image: AssetImage('images/appLogo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
