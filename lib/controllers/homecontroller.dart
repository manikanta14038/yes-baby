// ignore_for_file: prefer_typing_uninitialized_variables

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:yes_baby/controllers/authcontroller.dart';
import 'package:yes_baby/screens/signUp/registerdetail_screen.dart';
import 'package:yes_baby/services/homeservice.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/dialogs.dart';

class HomeController extends GetxController {
  HomeService homeService = HomeService();
  late VideoPlayerController player;

  var userDetails,
      profileDetails,
      topicDetails,
      topicDetails1,
      topicDetails2,
      prayer,
      wordOfGod,
      topicDetailed;

  String nextTopic = '', previousTopic = '';
  List homeSlider = [];
  bool notificationReceived = false, homeLoad = true, profileLoad = true;

  notify({required bool val}) {
    notificationReceived = val;
    update();
  }

  getHome() async {
    try {
      var res = await homeService.homeDetails();
      if (res != null && res['status'] == '200') {
        userDetails = res['VD'];
        topicDetails = res['TD'];
        topicDetails1 = res['TD2'];
        topicDetails2 = res['TD3'];
        homeSlider = res['HomeSlider'];
        prayer = res['Prayer'];
        wordOfGod = res['WordOfGod'];
        homeLoad = false;
        update();
        if (userDetails == null) {
          Get.offUntil(
            MaterialPageRoute(builder: (ctx) => const RegisterDetailScreen()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getTopicDetails({topicId}) async {
    topicDetailed = null;
    update();
    var res = await homeService.topicDetails(topicId: topicId);
    if (res != null && res['status'] == '200') {
      topicDetailed = res['TD'];
      nextTopic = res['Next'];
      previousTopic = res['Previous'];
      player = VideoPlayerController.network(topicDetailed['video']);

      player.initialize().then((_) => update());
      update();
    }
  }

  playVideo() {
    player.value.isPlaying ? player.pause() : player.play();
    update();
  }

  getProfile() async {
    final AuthController authController = Get.put(AuthController());
    var res = await homeService.userProfile();
    if (res != null && res['status'] == '200') {
      profileDetails = res['CD'];
      authController.setData(data: profileDetails);
      profileLoad = false;

      update();
    }
  }

  updateUserProfile(context) async {
    final AuthController a = Get.find<AuthController>();
    if (a.formKey.currentState!.validate()) {
      try {
        if (a.countryId.isEmpty) {
          Fluttertoast.showToast(msg: 'Select Country');
        } else {
          showSpinner();
          var res = await homeService.updateProfile(
            fName: a.fName.text,
            lName: a.lName.text,
            mobile: a.mobile.text,
            email: a.email.text,
            password: a.password.text,
            confirmPassword: a.confirmPassword.text,
            countryId: a.countryId,
            profilePic: a.profilePic,
            dueDate: a.babyDueDate,
          );
          hideSpinner();
          if (res != null && res['status'] == '200') {
            getProfile();
            getHome();
            msgDialog(context, text: 'Profile Updated');
            Future.delayed(const Duration(seconds: 2), () {
              Get.back();
            });
          } else {
            Fluttertoast.showToast(msg: res['message'].toString());
          }
        }
      } catch (e) {
        hideSpinner();
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
