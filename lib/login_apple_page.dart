// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginApplePage extends StatefulWidget {
  const LoginApplePage({super.key});

  @override
  State<LoginApplePage> createState() => _LoginApplePageState();
}

class _LoginApplePageState extends State<LoginApplePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example app: Sign in with Apple'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SignInWithAppleButton(
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                );

                final oauthCredential = OAuthProvider("apple.com").credential(
                  idToken: credential.identityToken,
                );

                print(credential);

                final authResult =
                    await _firebaseAuth.signInWithCredential(oauthCredential);

                final displayName =
                    '${credential.givenName} ${credential.familyName}';
                final userEmail = '${credential.email}';

                print(displayName);
                print(userEmail);
                print(authResult);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CupertinoButton(
              color: Colors.blue,
              onPressed: signOut,
              child: const Text(
                "LOGOUT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
