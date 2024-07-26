import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:finalproject/view/screens/localstorege/localstorage.dart';
import 'package:finalproject/viewmodel/bottombar/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  Future<void> fetchToken() async {
    token = await LocalStorage.getData();
    print("Token: $token");
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      splash: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.4,
                    child: LottieBuilder.network(
                      "https://lottie.host/4d4243fe-8b41-4fd1-a23e-8faec41ad578/G628q6o27t.json",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      nextScreen: token == null ? MainPage() : MainPage(),
      splashIconSize: size.height * 0.5,  
      duration: 2000,
    );
  }
}