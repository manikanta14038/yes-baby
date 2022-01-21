import 'dart:convert';
import 'dart:io';
import 'package:get/get_connect/connect.dart';
import 'package:yes_baby/utils/user_data.dart';

import 'firebase_messaging.dart';

class AuthService extends GetConnect {
  Future registerUser() async {
    var body = FormData({'security_token': '07074158857cf9694e0774d49fbc8e6a'});

    var res = await post('https://yesbaby.org/app/register', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }

  Future submitRegister(
      {fName,
      lName,
      mobile,
      email,
      password,
      confirmPassword,
      countryId,
      File? profilePic}) async {
    var appToken = await NotificationService().getFCMToken();
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      "first_name": fName,
      "last_name": lName,
      "mobile": mobile,
      "email": email,
      "country_id": countryId,
      "password": password,
      "password_confir": confirmPassword,
      'app_token': appToken,
    });

    if (profilePic!.path.isNotEmpty) {
      body.files.add(
        MapEntry(
          'image',
          MultipartFile(profilePic, filename: profilePic.path.split('/').last),
        ),
      );
    }
    var res = await post('https://yesbaby.org/app/register-submit', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }

  Future registerDetails() async {
    var userId = await UserData().getUserId();
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'app_users_id': userId,
    });

    var res = await post('https://yesbaby.org/app/register-details', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  Future registerSubmitDetails({monthId, weekId, day, dueDate}) async {
    var userId = await UserData().getUserId();
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'app_users_id': userId,
      'months_id': monthId,
      'weeks_id': weekId,
      'day': day,
      'due_date': dueDate,
    });

    var res =
        await post('https://yesbaby.org/app/register-details-submit', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  Future loginUser({email, password}) async {
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'email': email,
      'password': password,
      'app_token': 'qwedasfansgebbtenu',
    });

    var res = await post(
      'https://yesbaby.org/app/login',
      body,
    );
    // print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }

  Future forgotPassword({email}) async {
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'email': email,
    });

    var res = await post('https://yesbaby.org/app/forgot-password', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }

  Future verifyOtp({email, userId, otp}) async {
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'email': email,
      'app_users_id': userId,
      'otp': otp
    });

    var res = await post('https://yesbaby.org/app/verify-otp', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }

  Future changepassword({email, userId, confrimPassword, password}) async {
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'email': email,
      'app_users_id': userId,
      'password': password,
      'password_confir': confrimPassword,
    });

    var res = await post('https://yesbaby.org/app/reset-password', body);
    print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }

  Future resendOtp({email, userId}) async {
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'email': email,
      'app_users_id': userId,
    });

    var res = await post('https://yesbaby.org/app/resend-otp', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }
}
