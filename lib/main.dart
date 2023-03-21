// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_testing/bloc_rxdart_page.dart';
import 'package:project_testing/login_apple_page.dart';
import 'package:project_testing/login_facebook_page.dart';
import 'package:project_testing/login_google_page.dart';
import 'package:project_testing/speech_text_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/speech-text': (context) => const SpeechTextPage(),
        '/bloc-rxdart': (context) => const BlocRxdartPage(),
        '/login-facebook': (context) => const LoginFacebookPage(),
        '/login-google': (context) => const LoginGooglePage(),
        '/login-apple': (context) => const LoginApplePage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Project Testing'),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed("/speech-text");
                  },
                  child: const Text(
                    "Move to speech text",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/bloc-rxdart');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.green,
                    child: const Text(
                      "Bloc RxDart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/login-facebook');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook_rounded,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "Login Facebook",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/login-google');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata_rounded,
                          color: Colors.green.shade900,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "Login Google",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/login-apple');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.apple,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Login Apple",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
