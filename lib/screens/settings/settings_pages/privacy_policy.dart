import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Privacy Policy"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
          height: 500,
          width: double.infinity,
          child: Text(
            "We collect information about your activity in our services, which we use to do things like recommending a YouTube video you might like. Terms you search for videos you watch. Views and interactions with content and ads. Voice and audio information. Purchase activity. People with whom you communicate or share content. Activity on third-party sites and apps that use our services.Chrome browsing history you have synced with your Google Account. If you use our services to make and receive calls or send and receive messages, we may collect call and message log information like your phone number, calling-party number, receiving-party number, forwarding numbers, sender and recipient email address, time and date of calls and messages, duration of calls, routing information, and types and volumes of calls and messages. You can visit your Google Account to find and manage activity information that is saved in your account.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
