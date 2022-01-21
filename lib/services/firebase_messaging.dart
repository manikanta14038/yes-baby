import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:yes_baby/controllers/homecontroller.dart';
import 'package:yes_baby/screens/notificationScreen.dart';

class NotificationService {
  final HomeController homeController = Get.find<HomeController>();
  getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var token = await messaging.getToken();
    if (token != null) {
      return token;
    }
  }

  checkforMsg() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      homeController.notify(val:true);
      print("message recieved");

      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification!.body);

      Get.to(() => NotificationScreen());
    });
  }
}
