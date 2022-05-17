import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:news_app/logic/auth/authentication.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

@immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color:Colors.white,
      child: AnimatedSplashScreen(
        backgroundColor: Colors.transparent,
        splash: Image.asset('assets/logo.png'),
        nextScreen: Authentication.user == null
            ? LoginScreen()
            : const HomeScreen(),
      ),
    );
  }
}
