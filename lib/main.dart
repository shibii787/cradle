import 'package:cradle/common/colors.dart';
import 'package:cradle/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Variables for measurements
var h;
var w;

/// For date
DateTime today = DateTime.now();

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white
      ),
      home: const SplashScreen(),
    );
  }
}
