// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGooglePage extends StatefulWidget {
  const LoginGooglePage({super.key});

  @override
  State<LoginGooglePage> createState() => _LoginGooglePageState();
}

class _LoginGooglePageState extends State<LoginGooglePage> {
  String? displayName;
  String? email;
  Map<String, dynamic>? _googleUser;
  Map<String, dynamic>? _googleAuth;

  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    print(pretty);
    return pretty;
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      Map<String, dynamic> toJson() => {
            'id': googleUser.id,
            'displayName': googleUser.displayName,
            'email': googleUser.email,
            'photoUrl': googleUser.photoUrl,
            'serverAuthCode': googleUser.serverAuthCode,
          };
      setState(() {
        _googleUser = toJson();
        print(_googleUser);
      });
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth != null) {
      Map<String, dynamic> toJson() => {
            'accessToken': googleAuth.accessToken,
            'idToken': googleAuth.idToken
          };
      setState(() {
        _googleAuth = toJson();
        print(_googleAuth);
      });

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      displayName = googleUser?.displayName;
      email = googleUser?.email;

      print(googleUser?.displayName);
      print(googleUser?.email);
      print(googleAuth.idToken);
      print(googleAuth.accessToken);
      print(credential);
      var x = FirebaseAuth.instance.signInWithCredential(credential);
      print(x);
      setState(() {});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  signOut() async {
    await GoogleSignIn().signOut();
    displayName = null;
    email = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Auth Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                email != null ? "$email - $displayName" : "NO LOGGED",
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                onPressed: email != null ? signOut : signInWithGoogle,
                child: Text(
                  email != null ? "LOGOUT" : "LOGIN",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
