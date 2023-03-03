import 'package:flutter/foundation.dart';
import 'package:money_manager_app/models/transacrtion_model.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:money_manager_app/models/category_modal.dart';

// ValueNotifier totalAmount = ValueNotifier(0.0);
// ValueNotifier incomeTotal = ValueNotifier(0.0);
// ValueNotifier expenseTotal = ValueNotifier(0.0);

class AmountCalculation with ChangeNotifier {
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
