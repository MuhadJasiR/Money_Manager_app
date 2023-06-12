import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/db/category_db.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:provider/provider.dart';

class ExpenseScreenPage extends StatelessWidget {
  const ExpenseScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<CategoryDB>(builder: ((context, newList, child) {
          return newList.expenseCategoryListListener.isNotEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount;
                    if (screenWidth < 600) {
                      crossAxisCount = 2;
                    } else {
                      crossAxisCount = 4;
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (2 / 1.3),
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: newList.expenseCategoryListListener.length,
                        itemBuilder: ((context, index) {
                          final category =
                              newList.expenseCategoryListListener[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal[200],
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: ((context) {
                                                return AlertDialog(
                                                  content: const Text(
                                                      "Do you want to delete"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("No")),
                                                    TextButton(
                                                        onPressed: () {
                                                          CategoryDB.instance
                                                              .deleteCategoty(
                                                                  category.id);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("Yes")),
                                                  ],
                                                );
                                              }));
                                        },
                                        icon: const Icon(
                                          Icons.dangerous_sharp,
                                          color: Colors.red,
                                          size: 20,
                                        )),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          category.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }));
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Column(
                    children: [
                      Image.asset(
                        "asset/98979-empy-list.gif",
                        height: 250,
                      ),
                    ],
                  ),
                );
        })));
  }
}
