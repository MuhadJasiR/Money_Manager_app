import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/transaction_db.dart';
import '../../../models/category_modal.dart';

class PopUpMenuItem extends StatelessWidget {
  const PopUpMenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.filter_list_outlined),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: (() {
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                TransactionDB.instance.transactionListNotifier;
            Provider.of<TransactionDB>(context, listen: false)
                .notifyListeners();
          }),
          child: const Text("All"),
        ),
        PopupMenuItem(
          onTap: (() {
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                TransactionDB.instance.transactionListNotifier;
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                Provider.of<TransactionDB>(context, listen: false)
                    .allUsers
                    .where((element) =>
                        element.category.type == CategoryType.income)
                    .toList();
            Provider.of<TransactionDB>(context, listen: false)
                .notifyListeners();
            log(Provider.of<TransactionDB>(context, listen: false)
                .allUsers
                .toString());
          }),
          child: const Text("Income"),
        ),
        PopupMenuItem(
          onTap: (() {
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                TransactionDB.instance.transactionListNotifier;
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                Provider.of<TransactionDB>(context, listen: false)
                    .allUsers
                    .where((element) =>
                        element.category.type == CategoryType.expense)
                    .toList();
            Provider.of<TransactionDB>(context, listen: false)
                .notifyListeners();
          }),
          child: const Text("Expense"),
        ),
      ],
    );
  }
}
