import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/controller/category_db.dart';
import 'package:money_manager_app/controller/transaction_db.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:money_manager_app/view/home/edit_transaction_screen.dart';
import 'package:money_manager_app/view/home/flipping_container.dart';
import 'package:money_manager_app/view/home/view_all.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TransactionDB>(context, listen: false).allUsers =
          TransactionDB().transactionListNotifier;
    });
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUi();

    Provider.of<TransactionDB>(context, listen: false).totalIncomeExpenses();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 247, 255),
        body: Column(
          children: [
            SizedBox(
              child: Stack(
                // alignment: AlignmentDirectional.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 35, 43, 255),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      DateFormat("y MMMM\nEEEE d").format(DateTime.now()),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 212, 212, 212),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const Center(
                        child: Text(
                          "Total Balance",
                          style: TextStyle(
                              color: Color.fromARGB(255, 212, 212, 212),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(child: Consumer(builder: ((context, value, child) {
                        return Text(
                          "\u{20B9} ${Provider.of<TransactionDB>(context).totalAmount}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        );
                      })))
                    ],
                  ),
                  Positioned(
                    top: 160,
                    child: Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      child: FlippingContainer(),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 130, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Transaction",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Consumer<TransactionDB>(
                          builder: ((context, value, child) {
                        return Visibility(
                          visible: value.transactionListNotifier.isNotEmpty,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (ctx) {
                                  return const ViewListScreen();
                                }));
                              },
                              child: const Text("View All")),
                        );
                      }))
                    ],
                  ),
                ),
              ],
            ),

            // Transaction list,
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Consumer<TransactionDB>(
                      builder: ((context, newList, child) {
                    return newList.transactionListNotifier.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                newList.transactionListNotifier.length > 5
                                    ? 5
                                    : newList.transactionListNotifier.length,
                            itemBuilder: (context, index) {
                              final value =
                                  newList.transactionListNotifier[index];
                              if (value.id != null) {
                                return Slidable(
                                  key: Key(value.id!),
                                  startActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                        "DO you want to delete"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("No")),
                                                      TextButton(
                                                          onPressed: () {
                                                            TransactionDB
                                                                .instance
                                                                .deleteTransaction(
                                                                    value);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Yes")),
                                                    ],
                                                  );
                                                }));
                                          },
                                          backgroundColor: const Color.fromARGB(
                                              255, 239, 247, 255),
                                          foregroundColor: Colors.red,
                                          icon: Icons.delete_outlined,
                                          label: "Delete",
                                        )
                                      ]),
                                  endActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (ctx) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return EditTransactionScreen(
                                                obj: value,
                                                id: value.id,
                                              );
                                            })));
                                          },
                                          backgroundColor: const Color.fromARGB(
                                              255, 239, 247, 255),
                                          foregroundColor: Colors.blue,
                                          icon: Icons.edit,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          leading: value.category.type ==
                                                  CategoryType.income
                                              ? const Icon(
                                                  Icons.arrow_upward,
                                                  color: Colors.blue,
                                                  size: 30,
                                                )
                                              : const Icon(
                                                  Icons.arrow_downward,
                                                  color: Color.fromARGB(
                                                      255, 255, 0, 55),
                                                  size: 30,
                                                ),
                                          title: Text(
                                            value.category.name,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(parseDate(value.date)),
                                          trailing: Text(
                                            " ${value.amount}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // ignore: prefer_const_constructors
                                return Column(
                                  children: const [Text("Value id null")],
                                );
                              }
                            })
                        // image which will if there is transaction li
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Image.asset(
                                  "asset/126320-empty-box3-unscreen.gif",
                                  height: 250,
                                ),
                              ],
                            ),
                          );
                  }))),
            )
          ],
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
