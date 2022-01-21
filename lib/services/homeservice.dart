import 'dart:io';
import 'package:get/get_connect/connect.dart';
import 'package:yes_baby/utils/user_data.dart';

class HomeService extends GetConnect {
  Future homeDetails() async {
    var userId = await UserData().getUserId();
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'app_users_id': userId,
    });

    var res = await post('https://yesbaby.org/app/home', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  Future topicDetails({topicId}) async {
    var userId = await UserData().getUserId();
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'app_users_id': userId,
      'topic_id': topicId,
    });

    var res = await post('https://yesbaby.org/app/topic-details', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  Future userProfile() async {
    var userId = await UserData().getUserId();
    // print(userId);
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'app_users_id': userId,
    });

    var res = await post('https://yesbaby.org/app/profile', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  Future<List> userNotifications() async {
    var userId = await UserData().getUserId();
    var body = FormData({
      'security_token': '07074158857cf9694e0774d49fbc8e6a',
      'app_users_id': userId,
      'start': '0',
    });

    var res = await post('https://yesbaby.org/app/notifications', body);
    // print(res.body);
    if (res.statusCode == 200) {
      return res.body['ND'];
    } else {
      return [];
    }
  }

  Future updateProfile(
      {fName,
      lName,
      mobile,
      email,
      password,
      confirmPassword,
      countryId,
      dueDate,
      File? profilePic}) async {
    var userId = await UserData().getUserId();
    var body = FormData({
      "app_users_id": userId,
      "security_token": '07074158857cf9694e0774d49fbc8e6a',
      "first_name": fName,
      "last_name": lName,
      "mobile": mobile,
      "email": email,
      "country_id": countryId,
      // "password": password,
      // "password_confir": confirmPassword,
      "due_date": dueDate,
    });

    if (profilePic!.path.isNotEmpty) {
      body.files.add(
        MapEntry(
          'image',
          MultipartFile(profilePic, filename: profilePic.path.split('/').last),
        ),
      );
    }

    var res = await post('https://yesbaby.org/app/edit-profile', body);
    print(res.body);
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return null;
    }
  }
}
