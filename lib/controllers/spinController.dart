import 'package:get/get.dart';

class SpinController extends GetxController {
  var spin = false.obs;
  var text = 'Please wait...'.obs;

  show(msg) {
    spin.value = true;
    if (msg != null) {
      text.value = msg;
    }
  }

  hide() {
    spin.value = false;
    text.value = 'Please wait...';
  }
}
