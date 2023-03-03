import 'package:flutter/material.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:provider/provider.dart';

class FiltrationViewList extends StatelessWidget {
  const FiltrationViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.calendar_month),
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
            TransactionDB.instance.transactionListNotifier;
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                Provider.of<TransactionDB>(context, listen: false)
                    .allUsers
                    .where((element) =>
                        element.date.day == DateTime.now().day &&
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
            Provider.of<TransactionDB>(context, listen: false)
                .notifyListeners();
          }),
          child: const Text("Today"),
        ),
        PopupMenuItem(
          onTap: (() {
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                TransactionDB.instance.transactionListNotifier;
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                Provider.of<TransactionDB>(context, listen: false)
                    .allUsers
                    .where((element) =>
                        element.date.day == DateTime.now().day - 1 &&
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
            Provider.of<TransactionDB>(context, listen: false)
                .notifyListeners();
          }),
          child: const Text("Yesterday"),
        ),
        PopupMenuItem(
          onTap: (() {
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                TransactionDB.instance.transactionListNotifier;
            Provider.of<TransactionDB>(context, listen: false).allUsers =
                Provider.of<TransactionDB>(context, listen: false)
                    .allUsers
                    .where((element) =>
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
            Provider.of<TransactionDB>(context, listen: false)
                .notifyListeners();
          }),
          child: const Text("Month"),
        ),
      ],
    );
  }
}
