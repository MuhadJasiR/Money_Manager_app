import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Image.asset("asset/9888-money-money-money.gif"),
        const Text(
          "Welcome to Money\n Manager",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(145, 139, 255, 1)),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "You're amazing for taking this first step\n towards getting better control over your \nmoney and financial goals",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 105, 105, 105)),
        ),
        const SizedBox(
          height: 65,
        ),
      ],
    );
  }
}
