// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset("asset/90507-money-saving.gif"),
          Text(
            "Control your spending habitsand start saving",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(145, 139, 255, 1)),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Money manager helps you control your\n spending, track expenses, and\n ultimately save more money",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 105, 105)),
          )
        ],
      ),
    );
  }
}
