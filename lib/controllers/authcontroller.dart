import 'dart:io';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yes_baby/screens/changepassword_screen.dart';
import 'package:yes_baby/screens/enterotp_screen.dart';
import 'package:yes_baby/screens/homescreen.dart';
import 'package:yes_baby/screens/signUp/registerdetail_screen.dart';
import 'package:yes_baby/screens/signUp/registersubmit_screen.dart';
import 'package:yes_baby/screens/signin_screen.dart';
import 'package:yes_baby/services/authservice.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/utils/user_data.dart';
import 'package:yes_baby/widgets/dialogs.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      resetPassword = TextEditingController(),
      resetConfirmPassword = TextEditingController(),
      confirmPassword = TextEditingController(),
      forgotOtp = TextEditingController(),
      fName = TextEditingController(),
      lName = TextEditingController(),
      mobile = TextEditingController();
  FocusNode passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode(),
      emailNode = FocusNode();
  bool staySignnedIn = false,
      hidePassword = true,
      profilePasswordHide = true,
      profileConfirmPasswordHide = true,
      resetPasswordHide = true,
      resetConfirmPasswordHide = true;
  String userId = '',
      countryId = '',
      dropDownText = 'Select Country*',
      currentMonth = 'Current Month*',
      currentWeek = 'Current Week*',
      currentDay = 'Current Day*',
      babyDueDate = "Baby's Due Date*",
      monthId = '',
      weekId = '',
      dayId = '';
  File profilePic = File('');
  List countries = [], months = [], weeks = [], days = [];
  AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  reset() {
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    forgotOtp = TextEditingController();
    fName = TextEditingController();
    lName = TextEditingController();
    mobile = TextEditingController();
    dropDownText = 'Select Country*';
    countryId = '';
    profilePic = File('');
    update();
  }

  obscurePassword() {
    hidePassword = !hidePassword;
    update();
  }

  obscureProfilePassword() {
    profilePasswordHide = !profilePasswordHide;
    update();
  }

  obscureProfileConfirmPassword() {
    profileConfirmPasswordHide = !profileConfirmPasswordHide;
    update();
  }

  obscureResetPassword() {
    resetPasswordHide = !resetPasswordHide;
    update();
  }

  obscureResetConfirmPassword() {
    resetConfirmPasswordHide = !resetConfirmPasswordHide;
    update();
  }

  setData({data}) {
    email = TextEditingController(text: data['email']);
    password = TextEditingController();
    confirmPassword = TextEditingController();
    forgotOtp = TextEditingController();
    fName = TextEditingController(text: data['first_name']);
    lName = TextEditingController(text: data['last_name']);
    mobile = TextEditingController(text: data['mobile']);
    dropDownText = data['country'];
    countryId = data['country_id'];
    babyDueDate = data['due_date'];
  }

  resetDueInfo() {
    currentMonth = 'Current Month*';
    currentWeek = 'Current Week*';
    currentDay = 'Current Day*';
    babyDueDate = "Baby's Due Date*";
    monthId = '';
    weekId = '';
    dayId = '';
    update();
  }

  selectStaySigned() {
    staySignnedIn = !staySignnedIn;
    update();
  }

  selectCountry(v) {
    dropDownText = v;
    for (var country in countries) {
      if (country['country'] == v) {
        countryId = country['country_id'];
      }
    }
    update();
  }

  Future selectFile() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      profilePic = File(file.path);
      update();
    }
  }

  getCountries() async {
    var res = await authService.registerUser();
    if (res != null && res['status'] == '200') {
      countries = res['CL'];
      update();
    }
  }

  registerUser() async {
    showSpinner();

    var res = await authService.registerUser();
    if (res != null && res['status'] == '200') {
      countries = res['CL'];
      update();
    }
    hideSpinner();
  }

  registerDetails() async {
    showSpinner();

    var res = await authService.registerDetails();
    if (res != null && res['status'] == '200') {
      months = res['ML'];
      weeks = res['WL'];
      days = res['DL'];
      update();
    }
    hideSpinner();
  }

  registerDetailsSubmit() async {
    if (monthId.isNotEmpty && weekId.isNotEmpty && dayId.isNotEmpty) {
      showSpinner();
      var res = await authService.registerSubmitDetails(
        monthId: monthId,
        weekId: weekId,
        day: dayId,
        dueDate: babyDueDate,
      );

      if (res != null && res['status'] == '200') {
        Get.to(() => RegisterSubmitScreen(dueInfo: res['RDS']));
      }

      hideSpinner();
    } else {
      Fluttertoast.showToast(msg: 'All fields are mndatory');
    }
  }

  registerSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        if (countryId.isEmpty) {
          Fluttertoast.showToast(msg: 'Select Country');
        } else if (password.text == confirmPassword.text &&
            password.text.isNotEmpty) {
          showSpinner();
          var res = await authService.submitRegister(
            fName: fName.text,
            lName: lName.text,
            mobile: mobile.text,
            email: email.text,
            password: password.text,
            confirmPassword: confirmPassword.text,
            countryId: countryId,
            profilePic: profilePic,
          );
          hideSpinner();
          if (res != null && res['status'] == '200') {
            userId = "${res['app_users_id']}";
            UserData().setUserId(userId);
            Get.to(() => const RegisterDetailScreen());
          } else {
            Fluttertoast.showToast(msg: res['message'].toString());
          }
        } else {
          Fluttertoast.showToast(msg: "Both passwords should be same");
        }
      } catch (e) {
        hideSpinner();
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  signInUser() async {
    try {
      showSpinner();

      var res = await authService.loginUser(
        email: email.text,
        password: password.text,
      );
      hideSpinner();
      if (res != null && res['status'] == '200') {
        UserData().setStayLoggedIn(value: staySignnedIn);
        UserData().setUserId(res['UD']['app_users_id']);
        Get.offUntil(
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: res['message']);
      }
    } catch (e) {
      hideSpinner();
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  forgotPassword() async {
    if (GetUtils.isEmail(email.text)) {
      showSpinner();
      var res = await authService.forgotPassword(email: email.text);

      if (res != null && res['status'] == '200') {
        userId = res['app_users_id'];
        Get.to(() => const EnterOtpScreen());
      }
      hideSpinner();
    } else {
      Fluttertoast.showToast(msg: 'Enter valid email');
    }
  }

  verifyOtp() async {
    if (forgotOtp.text.length == 4) {
      try {
        showSpinner();
        var res = await authService.verifyOtp(
          email: email.text,
          otp: forgotOtp.text,
          userId: userId,
        );
        if (res != null && res['status'] == '200') {
          Get.to(() => const ChangePasswordScreen());
        } else {
          Fluttertoast.showToast(msg: res['message']);
        }

        hideSpinner();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: 'Enter 4-digit valid OTP');
    }
  }

  changeUserPassword(context) async {
    if (resetPassword.text.isEmpty || resetConfirmPassword.text.isEmpty) {
      Fluttertoast.showToast(msg: 'All fields are mandatory');
    } else if (resetPassword.text != resetConfirmPassword.text) {
      Fluttertoast.showToast(msg: 'Both passwords should match');
    } else {
      showSpinner();

      var res = await authService.changepassword(
        email: email.text,
        userId: userId,
        password: resetPassword.text,
        confrimPassword: resetConfirmPassword.text,
      );
      if (res != null && res['status'] == '200') {
        msgDialog(context, text: 'Password updated successfully!');
        Future.delayed(const Duration(seconds: 2), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (ctx) => const SigninScreen(),
            ),
            (route) => false,
          );
        });
      }
      hideSpinner();
    }
  }

  resendOtpUser() async {
    showSpinner();
    var res = await authService.resendOtp(email: email.text, userId: userId);

    if (res != null && res['status'] == '200') {
      forgotOtp.text = '';
      update();
      Fluttertoast.showToast(msg: 'OTP was resent to your email id');
    }
    hideSpinner();
  }
}
