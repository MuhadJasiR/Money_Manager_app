// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:money_manager_app/controller/transaction_db.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Consumer<TransactionDB>(builder: ((context, newList, child) {
            return ListView.builder(
                itemCount: newList.transactionListNotifier.length,
                itemBuilder: (context, index) {
                  final _value = newList.transactionListNotifier[index];
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: _value.type == CategoryType.income
                              ? const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.blue,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.arrow_downward,
                                  color: Color.fromARGB(255, 255, 0, 55),
                                  size: 30,
                                ),
                          title: Text(
                            _value.category.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(parseDate(_value.date)),
                          trailing: Text(
                            " ${_value.amount}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }))),
    );
  }

  String parseDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}
