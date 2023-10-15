import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class EventPref {
  static Future<User?> getUser() async {
    User? user;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = User.fromJson(mapUser);
    }
    if (kDebugMode) {
      print(user);
    }
    return user;
  }

  static Future<void> saveUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user.toJson());
    await pref.setString('user', stringUser);
  }

  static Future<void> deleteUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('user');
  }
}
