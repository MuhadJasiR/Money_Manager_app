import 'package:flutter/material.dart';
import 'package:money_manager_app/view/home/add_screen.dart';
import 'package:money_manager_app/view/category/categories.dart';
import 'package:money_manager_app/view/financial_chart/finalcial_report.dart';
import 'package:money_manager_app/view/home/home_screen.dart';
import 'package:money_manager_app/view/settings/settings.dart';
import 'package:money_manager_app/widgets/category_add_popup.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(BuildContext context, {super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavBar> {
  // static ValueNotifier<int> selectIndexNotifier = ValueNotifier(0);
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const Categories(),
    const FinancialChart(),
    const SettingScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: currentTab == 2 || currentTab == 3
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  switch (currentTab) {
                    case 0:
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return AddTransaction();
                      })));
                      break;
                    case 1:
                      showCategoryAddPopup(context,
                          categoryType: selectedCategoryNotifier.value);
                      break;
                    default:
                  }
                },
                // ignore: sort_child_properties_last
                child: const Icon(Icons.add),
                backgroundColor: const Color.fromARGB(255, 35, 43, 255),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          // shape: const CircularNotchedRectangle(),
          // notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const HomeScreen();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        size: 40,
                        color: currentTab == 0
                            ? const Color.fromARGB(255, 35, 43, 255)
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const Categories();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 40,
                        color: currentTab == 1
                            ? const Color.fromARGB(255, 35, 43, 255)
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const FinancialChart();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.donut_large_rounded,
                        size: 40,
                        color: currentTab == 2
                            ? const Color.fromARGB(255, 35, 43, 255)
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const SettingScreen();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 40,
                        color: currentTab == 3
                            ? const Color.fromARGB(255, 35, 43, 255)
                            : Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
