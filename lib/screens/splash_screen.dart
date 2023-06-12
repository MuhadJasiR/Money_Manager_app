// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/introduction_screen.dart';
import 'package:money_manager_app/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Timer(const Duration(seconds: 4), (() async { 
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool seen = (prefs.getBool("seen") ?? false);
          if (seen) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: ((context) {
              return BottomNavBar(context);
            })));
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: ((context) {
              return const IntroductionScreen();
            })));
          }
        }));
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                "asset/mainLogo.png",
                height: 150,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Money Manager",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

// Future checkFirstScreen(context) async {
//   await Future.delayed(Duration(seconds: 2));
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool _seen = (prefs.getBool('seen') ?? false);
//   if (_seen) {
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//       return BottomNavBar();
//     }));
//   } else {
//     // await prefs.setBool('seen', true);
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//       return IntroductionScreen();
//     }));
//   }
//   // prefs.clear();
// }
