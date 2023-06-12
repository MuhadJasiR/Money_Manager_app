// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:money_manager_app/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _nameTextcontroller = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Column(
          children: [
            Text(
              "Let get started by entering \nyour name",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 47, 140, 252)),
            ),
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _nameTextcontroller,
                decoration: InputDecoration(hintText: "Enter your name"),
              ),
            ),
            SizedBox(
                width: 100,
                child: ElevatedButton(
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
                    child: Text("Login")))
          ],
        ),
      ),
    );
  }
}
