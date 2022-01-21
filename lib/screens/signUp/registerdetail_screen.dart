//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/screens/signUp/registersubmit_screen.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/widgets.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/textfield.dart';

class RegisterDetailScreen extends StatefulWidget {
  const RegisterDetailScreen({Key? key}) : super(key: key);

  @override
  _RegisterDetailScreenState createState() => _RegisterDetailScreenState();
}

class _RegisterDetailScreenState extends State<RegisterDetailScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      authController.resetDueInfo();
      authController.registerDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        body: SafeArea(
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
                  SizedBox(height: height(context) * 0.04),
                  Text(
                    'Your baby is due',
                    style: GoogleFonts.montserrat(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.03),
                  Image(
                    height: height(context) * 0.19,
                    image: AssetImage('images/appLogo.png'),
                  ),
                  SizedBox(height: height(context) * 0.02),
                  Text(
                    'Please provide your current date of pregnancy and we would delight to give you the most helpful contents and materials.',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height(context) * 0.04),
                  loginDropField(
                    context,
                    text: authController.currentMonth,
                    list: authController.months,
                    value: 'month_text',
                    icon: 'calendar',
                    onChanged: (v) {
                      setState(() {
                        authController.currentMonth = v;
                      });
                      for (var val in authController.months) {
                        if (val['month_text'] == v) {
                          // print(val);
                          authController.monthId = val['months_id'];
                          // print(authController.monthId);
                        }
                      }
                    },
                  ),
                  loginDropField(
                    context,
                    text: authController.currentWeek,
                    list: authController.weeks,
                    icon: 'calendar',
                    value: 'week_text',
                    onChanged: (v) {
                      setState(() {
                        authController.currentWeek = v;
                      });
                      for (var val in authController.weeks) {
                        if (val['week_text'] == v) {
                          authController.weekId = val['weeks_id'];
                        }
                      }
                    },
                  ),
                  loginDropField(
                    context,
                    text: authController.currentDay,
                    list: authController.days,
                    icon: 'calendar',
                    value: 'day_text',
                    onChanged: (v) {
                      setState(() {
                        authController.currentDay = v;
                      });
                      for (var val in authController.days) {
                        if (val['day_text'] == v) {
                          authController.dayId = val['day'];
                        }
                      }
                    },
                  ),
                  loginDropField(
                    context,
                    text: authController.babyDueDate,
                    list: [],
                    value: '',
                    sufixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image(
                        height: 15,
                        image: AssetImage('images/calendar-plus.png'),
                      ),
                    ),
                    icon: 'calendar',
                    onChanged: (v) {},
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ).then((date) {
                        if (date != null) {
                          String month = date.month.toString().length == 2
                              ? "${date.month}"
                              : "0${date.month}";
                          String day = date.day.toString().length == 2
                              ? "${date.day}"
                              : "0${date.day}";
                          authController.babyDueDate =
                              '${date.year}-$month-$day';
                          setState(() {});
                        }
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: submitButton(
                      context,
                      text: 'Submit',
                      buttonColor: Color(0xff587391),
                      textColor: Colors.white,
                      onTap: authController.registerDetailsSubmit,
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
