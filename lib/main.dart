// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:project_testing/bloc_rxdart_page.dart';
import 'package:project_testing/login_facebook_page.dart';
import 'package:project_testing/speech_text_page.dart';

void main() {
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
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/login-facebook');
                  },
                  child: const Text(
                    "Login Facebook",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
