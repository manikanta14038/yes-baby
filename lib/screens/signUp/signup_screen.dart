//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/controllers/homecontroller.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/cards.dart';
import 'package:yes_baby/widgets/widgets.dart';
import 'package:yes_baby/widgets/buttons.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SignupScreen({required this.newUser});

  final bool newUser;
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());

  FocusNode fNameNode = FocusNode(),
      lNameNode = FocusNode(),
      mobileNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode(),
      dropdownNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      if (widget.newUser) {
        authController.reset();
        authController.registerUser();
      } else {
        authController.getCountries();
      }
    });

    super.initState();
  }

  refreshProfile() async {
    try {
      showSpinner();
      await homeController.getProfile();
      authController.profilePic = File('');

      hideSpinner();

      return true;
    } catch (e) {
      hideSpinner();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        bottomNavigationBar: Visibility(
          visible: !widget.newUser,
          child: bottomNav(context),
        ),
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              var d = await refreshProfile();
              return d;
            },
            child: Container(
              height: height(context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: decoration(),
              width: width(context),
              child: GetBuilder(
                init: AuthController(),
                builder: (_) => Form(
                  key: authController.formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 20),
                      appbar(
                          text: widget.newUser ? 'Sign Up' : 'Profile',
                          onTap: () async {
                            await refreshProfile();
                            authController.profilePic = File('');

                            Get.back();
                          }),
                      SizedBox(height: height(context) * 0.04),
                      Center(
                        child: widget.newUser &&
                                authController.profilePic.path.isEmpty
                            ? CircleAvatar(
                                radius: width(context) * 0.12,
                                backgroundImage: AssetImage('images/pic.png'),
                              )
                            : authController.profilePic.path.isNotEmpty
                                ? CircleAvatar(
                                    radius: width(context) * 0.12,
                                    backgroundImage: FileImage(
                                      File(authController.profilePic.path),
                                    ),
                                  )
                                : homeController.profileDetails['image'] != null
                                    ? CircleAvatar(
                                        radius: width(context) * 0.12,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                homeController
                                                    .profileDetails['image']),
                                      )
                                    : CircleAvatar(
                                        radius: width(context) * 0.12,
                                        backgroundImage:
                                            AssetImage('images/pic.png'),
                                      ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          authController.selectFile();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 14,
                        ),
                      ),
                      widget.newUser
                          ? Container()
                          : Column(
                              children: [
                                SizedBox(height: 10),
                                timerClock(
                                  context,
                                  month: homeController.userDetails['month']
                                      .toString()
                                      .padLeft(2, '0'),
                                  week: homeController.userDetails['week']
                                      .toString()
                                      .padLeft(2, '0'),
                                  day: homeController.userDetails['day']
                                      .toString()
                                      .padLeft(2, '0'),
                                  small: true,
                                ),
                                SizedBox(height: 10),
                                GetBuilder(
                                  init: HomeController(),
                                  builder: (_) => RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Due Date ',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                        TextSpan(
                                          text:
                                              ' ${homeController.userDetails['due_date_view']}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                      Visibility(
                        visible: widget.newUser,
                        child: SizedBox(height: height(context) * 0.08),
                      ),
                      loginField(
                        context,
                        text: 'First Name*',
                        icon: 'person',
                        focusNode: fNameNode,
                        controller: authController.fName,
                        onSubmit: (v) {
                          lNameNode.requestFocus();
                        },
                      ),
                      loginField(
                        context,
                        text: 'Last Name*',
                        icon: 'person',
                        focusNode: lNameNode,
                        controller: authController.lName,
                        onSubmit: (v) {
                          mobileNode.requestFocus();
                        },
                      ),
                      loginField(
                        context,
                        text: 'Mobile Number',
                        icon: 'mobile',
                        focusNode: mobileNode,
                        controller: authController.mobile,
                        keyboard: TextInputType.phone,
                        onSubmit: (v) {
                          emailNode.requestFocus();
                        },
                      ),
                      loginField(
                        context,
                        text: 'Email Address*',
                        icon: 'email',
                        focusNode: emailNode,
                        controller: authController.email,
                        onSubmit: (v) {
                          passwordNode.requestFocus();
                        },
                      ),
                      Visibility(
                        visible: widget.newUser,
                        child: loginField(
                          context,
                          text: 'Password*',
                          icon: 'lock',
                          focusNode: passwordNode,
                          controller: authController.password,
                          onSubmit: (v) {
                            confirmPasswordNode.requestFocus();
                          },
                          obscureText: authController.profilePasswordHide,
                          obscureTap: authController.obscureProfilePassword,
                        ),
                      ),
                      Visibility(
                        visible: widget.newUser,
                        child: loginField(
                          context,
                          text: 'Confirm Password*',
                          icon: 'lock',
                          focusNode: confirmPasswordNode,
                          controller: authController.confirmPassword,
                          onSubmit: (v) {
                            dropdownNode.requestFocus();
                          },
                          obscureText:
                              authController.profileConfirmPasswordHide,
                          obscureTap:
                              authController.obscureProfileConfirmPassword,
                        ),
                      ),
                      loginDropField(
                        context,
                        text: authController.dropDownText,
                        icon: 'globe',
                        list: authController.countries,
                        value: 'country',
                        focusNode: dropdownNode,
                        onChanged: (v) {
                          authController.selectCountry(v);
                        },
                      ),
                      widget.newUser
                          ? Container()
                          : loginDropField(
                              context,
                              text: authController.babyDueDate,
                              value: '',
                              list: [],
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
                                    String month =
                                        date.month.toString().length == 2
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
                          text: widget.newUser ? 'Next' : 'Update',
                          buttonColor: Color(0xff587391),
                          textColor: Colors.white,
                          onTap: () {
                            if (widget.newUser) {
                              authController.registerSubmit();
                            } else {
                              homeController.updateUserProfile(context);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
