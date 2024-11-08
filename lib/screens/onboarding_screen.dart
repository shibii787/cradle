import 'package:cradle/common/onboarding.dart';
import 'package:cradle/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: w * 1,
        child: PageView.builder(
          controller: controller,
          padEnds: false,
          itemCount: onBodyContent.length,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: h * 0.5,
                    width: w * 1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(w * 0.05)),
                        image: DecorationImage(
                            image: AssetImage(onBodyContent[index].image),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(height: h * 0.05),
                  Text(
                    onBodyContent[index].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: h * 0.05),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        2,
                        (index) {
                          return Container(
                            height: 12,
                            width: currentIndex == index ? w * 0.095 : w * 0.065,
                            margin: EdgeInsets.only(right: w * 0.04),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w * 0.03),
                                color: currentIndex == index
                                    ? Colors.black
                                    : Colors.white),
                          );
                        },
                      )),
                  SizedBox(height: h * 0.02),
                  InkWell(
                    onTap: () {
                      if (currentIndex == 1) {
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomeScreen(),));
                      } else {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Container(
                      height: h * 0.08,
                      width: w * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(w * 0.1)),
                      child: Center(
                        child: Text(currentIndex == 1 ? "Get Started" : "Next",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
