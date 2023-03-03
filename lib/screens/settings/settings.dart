import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_app/models/transacrtion_model.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:money_manager_app/screens/settings/settings_pages/about_page.dart';
import 'package:money_manager_app/screens/settings/settings_pages/privacy_policy.dart';
import 'package:money_manager_app/screens/splash_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AboutScreen())));
                },
                leading: const Icon(Icons.assignment_late_sharp,
                    color: Color.fromARGB(255, 45, 140, 255)),
                title: const Text("About"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Share.share(
                      'hey! check out this new app https://play.google.com/store/apps/dev?id=7327906935422413621');
                },
                leading: const Icon(
                  Icons.share,
                  color: Color.fromARGB(255, 45, 140, 255),
                ),
                title: const Text("Share"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const PrivacyPolicyScreen();
                  })));
                },
                leading: const Icon(Icons.privacy_tip,
                    color: Color.fromARGB(255, 45, 140, 255)),
                title: const Text("Privacy & policy"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Are you sure to Reset"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.clear();

                                  final transactionDb =
                                      await Hive.openBox<TransactionModel>(
                                          'transaction-database');
                                  final categoryDb =
                                      await Hive.openBox<CategoryModel>(
                                          'category-database');

                                  categoryDb.clear();
                                  transactionDb.clear();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      });
                },
                leading: const Icon(Icons.restart_alt,
                    color: Color.fromARGB(255, 45, 140, 255)),
                title: const Text("Reset app"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "version 1.0.1",
              style: TextStyle(color: Colors.black12),
            )
          ],
        ),
      ),
    );
  }
}
