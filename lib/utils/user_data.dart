import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  setUserId(id) async {
    final SharedPreferences c = await SharedPreferences.getInstance();
    c.setString('id', id);
  }

  getUserId() async {
    final SharedPreferences c = await SharedPreferences.getInstance();
    return c.getString('id');
  }

  setStayLoggedIn({value}) async {
    final SharedPreferences c = await SharedPreferences.getInstance();
    return c.setBool('signnedIn',value);
  }

  getStayLoggedIn() async {
    final SharedPreferences c = await SharedPreferences.getInstance();
    return c.getBool('signnedIn');
  }
}
