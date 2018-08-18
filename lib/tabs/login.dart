import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<FirebaseUser> _signInFacebook() async {

    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);

    FirebaseUser user =
        await _auth.signInWithFacebook(accessToken: result.accessToken.token);

    print("User Name : ${user.displayName}");
    return user;
  }

  Future<FirebaseUser> _signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    print("User Name : ${user.displayName}");
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Center(child: new Image.asset('images/kefir_logo.png')),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton.icon(
              icon: Icon(
                FontAwesomeIcons.google,
                size: 18.0,
              ),
              color: Color(0xFFdb3236),
              textColor: Colors.white,
              label: Text('Entrar com Google'),
              onPressed: () => _signInGoogle()
                  .then((FirebaseUser user) =>
                      Navigator.of(context).pushReplacementNamed('/tabs'))
                  .catchError((e) => print(e)),
            ),
            new RaisedButton.icon(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 18.0,
              ),
              color: Color(0xFF3b5998),
              textColor: Colors.white,
              label: Text('Entrar com Facebook'),
              onPressed: () => _signInFacebook()
                  .then((FirebaseUser user) =>
                      Navigator.of(context).pushReplacementNamed('/tabs'))
                  .catchError((e) => print(e)),
            )
          ],
        ),
      ),
    );
  }
}
