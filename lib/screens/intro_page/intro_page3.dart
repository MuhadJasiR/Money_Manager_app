// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset("asset/93344-money-investment.gif"),
          const Text(
            "Together we'll reach your\n financial goals",
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
            "Money manager will helps you stay focused\n on tracking your spending habits and reach\n your financial goals.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 105, 105)),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
