import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'modules/login/login_controller.dart';
import 'shared/models/user_model.dart';
import 'widgets/social_login/social_login_button.dart';

void main() {
  runApp(GoogleSignInApp());
}

class GoogleSignInApp extends StatefulWidget {
  const GoogleSignInApp({Key? key}) : super(key: key);

  @override
  _GoogleSignInAppState createState() => _GoogleSignInAppState();
}

class _GoogleSignInAppState extends State<GoogleSignInApp> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  LoginController controller = LoginController();
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Sign In (Signed ' + (user == null ? 'out' : 'in') + ') '),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: user != null
                      ? null
                      : () async {
                          await _googleSignIn.signIn();
                          setState(() {});
                        }),
              ElevatedButton(
                  child: Text('Sign Out'),
                  onPressed: user == null
                      ? null
                      : () async {
                          await _googleSignIn.signOut();
                          setState(() {});
                        }),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: SocialLoginButton(
                  onTap: () async {
                    //print("clicou");
                    UserModel? user = await controller.googleSignIn();
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, "/home", arguments: user);
                    } else {
                      Navigator.pushReplacementNamed(context, "/login");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
