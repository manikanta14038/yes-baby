
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:yes_baby/controllers/spinController.dart';
import 'package:yes_baby/utils/screen_size.dart';

// double width(context) => MediaQuery.of(context).size.width;
// double height(context) => MediaQuery.of(context).size.width;

//custom spinner
class SpinWidget extends StatelessWidget {
  const SpinWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
      elevation: 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: width(context) * .8,
        height: height(context) * .1,
        padding: EdgeInsets.symmetric(horizontal: width(context) * .1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 2,
              // valueColor: AlwaysStoppedAnimation(blue),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

// ignore: must_be_immutable
class Spinner extends StatelessWidget {
  Spinner({this.child});
  Widget? child;

  SpinController controller = Get.put(SpinController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: controller.spin.value,
        child: child!,
        color: Colors.black87,
        progressIndicator: SpinWidget(
          text: controller.text.value,
        ),
      ),
    );
  }
}

showSpinner({String? message}) {
  SpinController controller = Get.find<SpinController>();
  controller.show(message);
}

hideSpinner() {
  SpinController controller = Get.find<SpinController>();
  controller.hide();
}
