// ignore_for_file: no_leading_underscores_for_local_identifiers, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/models/transacrtion_model.dart';
import 'package:money_manager_app/widgets/total_income_calculation.dart';

import '../models/category_modal.dart';

// abstract class TransactionDBfunctions {
//   Future<void> addTransaction(TransactionModel obj);
//   Future<List<TransactionModel>> getAllTransaction();
//   Future<void> deleteTransaction(TransactionModel obj);
//   Future<void> updateTransactionModel(TransactionModel value);
// }

class TransactionDB with ChangeNotifier {
  final TRANSACTION_DB_NAME = 'transaction-database';

  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }
  // ValueNotifier<List<TransactionModel>> transactionListNotifier =
  //     ValueNotifier([]);

  List<TransactionModel> transactionListNotifier = [];

  List allUsers = [];

  List<TransactionModel> doughnutChartNotifier = [];

  set setDoughnutChartNotifier(List<TransactionModel> newList) {
    doughnutChartNotifier = newList;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    // List<TransactionModel> result = [];
    allUsers = TransactionDB.instance.transactionListNotifier;
    if (enteredKeyword.isEmpty) {
      allUsers = transactionListNotifier;
    } else {
      allUsers = transactionListNotifier
          .where((element) => element.category.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase().trim()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
    refresh();
  }

  Future<void> refresh() async {
    final _list = await getAllTransaction();
    _list.sort(((first, second) => second.date.compareTo(first.date)));
    transactionListNotifier.clear();
    transactionListNotifier.addAll(_list);
    totalIncomeExpenses();
    notifyListeners();
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  Future<void> deleteTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await _db.delete(obj.id);

    refresh();
  }

  Future<void> updateTransactionModel(TransactionModel value) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(value.id, value);
    refresh();
  }

  double totalAmount = 0.0;
  double incomeTotal = 0.0;
  double expenseTotal = 0.0;
  totalIncomeExpenses() {
    totalAmount = 0;
    incomeTotal = 0;
    expenseTotal = 0;
    final List<TransactionModel> value =
        TransactionDB.instance.transactionListNotifier;
    for (int i = 0; i < value.length; i++) {
      if (CategoryType.income == value[i].category.type) {
        incomeTotal = incomeTotal + value[i].amount;
      } else {
        expenseTotal = expenseTotal + value[i].amount;
      }
    }
    totalAmount = incomeTotal - expenseTotal;
  }
}
