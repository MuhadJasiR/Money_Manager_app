import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About "),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
              height: 220,
              width: 300,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Money manager",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        "This is an app where you can add your\n daily transaction according to the \ncategory which it belong to.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Developed by",
                        style: TextStyle(color: Colors.black38),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Muhammad Jasir Ali",
                        style:
                            TextStyle(color: Color.fromARGB(255, 35, 45, 255)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
