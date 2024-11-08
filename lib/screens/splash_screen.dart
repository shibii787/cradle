import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cradle/common/colors.dart';
import 'package:cradle/screens/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigateToHome(){
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => const OnboardingScreen(),));
    },);
  }

  @override
  void initState() {
    navigateToHome();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.palette,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Center(
            child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              "CRADLE",
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4),
              colors: AppColors.palette,
            )
          ],
        )),
      ),
    );
  }
}
