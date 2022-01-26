import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_demo/shared/auth/auth_controller.dart';
import 'package:google_sign_in_demo/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();
  Future<UserModel?> googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
      );
      authController.setUser(user);
      return user;
    } catch (error) {
      authController.setUser(null);
      return null;
    }
  }
}
