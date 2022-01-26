import 'package:flutter/material.dart';
import 'package:google_sign_in_demo/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  Future<void> setUser(UserModel? user) async {
    if (user != null) {
      await saveUser(user);
      _user = user;
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(UserModel.fromJson(json));
      return;
    } else {
      setUser(null);
    }
  }
}
