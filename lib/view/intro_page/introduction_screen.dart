// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_manager_app/view/intro_page/indro_page1.dart';
import 'package:money_manager_app/view/intro_page/intro_page2.dart';
import 'package:money_manager_app/view/intro_page/intro_page3.dart';
import 'package:money_manager_app/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: onLastPage
                ? ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("seen", true);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => BottomNavBar(context))),
                          (route) => false);
                    },
                    child: const Text("GET STARTED"))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(2);
                        },
                        child: const Text("Skip"),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: const WormEffect(),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        child: const Text("Next"),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
