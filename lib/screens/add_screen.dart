// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/db/category_db.dart';
import 'package:money_manager_app/models/transacrtion_model.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:money_manager_app/widgets/category_add_popup.dart';
import 'package:provider/provider.dart';

List<Widget> transactionType = <Widget>[
  const Text("INCOME"),
  const Text("EXPENSE")
];
bool vertical = false;

class AddTransaction extends StatelessWidget {
  AddTransaction({super.key});

  final _formkey = GlobalKey<FormState>();
  String _selectedDateMessages = '';
  String _selectedCategoryMessages = '';
  // DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  final _notesTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  // late final List<bool> selectTranscationType = [true, false];

  // var selectedType;
  // String? _categoryId;

  @override
  Widget build(BuildContext context) {
    _selectedCategoryType = CategoryType.income;
    Provider.of<TransactionDB>(context, listen: false).selectTranscationType;

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 45, 35, 255),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    decoration: const BoxDecoration(),
                    height: 630,
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Transaction type",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Consumer<TransactionDB>(
                                    builder: ((context, value, child) =>
                                        ToggleButtons(
                                          onPressed: (int index) {
                                            for (int i = 0;
                                                i <
                                                    value.selectTranscationType
                                                        .length;
                                                i++) {
                                              value.selectTranscationType[i] =
                                                  i == index;
                                              value.selectedType = index;
                                              value.categoryId = null;
                                              value.notifyListeners();
                                            }
                                          },
                                          color: const Color.fromARGB(
                                              255, 128, 128, 128),
                                          borderColor: const Color.fromARGB(
                                              255, 45, 35, 255),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          selectedBorderColor:
                                              const Color.fromARGB(
                                                  255, 35, 43, 255),
                                          selectedColor: Colors.white,
                                          fillColor: const Color.fromARGB(
                                              255, 35, 43, 255),
                                          constraints: const BoxConstraints(
                                              minHeight: 30, minWidth: 85),
                                          isSelected:
                                              Provider.of<TransactionDB>(
                                                      context,
                                                      listen: false)
                                                  .selectTranscationType,
                                          children: transactionType,
                                        ))),
                                const SizedBox(height: 5),
                                const Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                    height: 40,
                                    child: Row(children: [
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54),
                                            ),
                                            child: Consumer2<CategoryDB,
                                                    TransactionDB>(
                                                builder: ((context, value,
                                                    value2, child) {
                                              return DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  hint: const Text(
                                                      " Select Category"),
                                                  value: value2.categoryId,
                                                  items: (value2.selectedType ==
                                                              1
                                                          ? value
                                                              .expenseCategoryListListener
                                                          : value
                                                              .incomeCategoryListListener)
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                      value: e.id,
                                                      child:
                                                          Text("   ${e.name}"),
                                                      onTap: () {
                                                        _selectedCategoryModel =
                                                            e;
                                                      },
                                                    );
                                                  }).toList(),
                                                  onChanged: (selectedValue) {
                                                    value2.categoryId =
                                                        selectedValue;
                                                  },
                                                ),
                                              );
                                            }))),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showCategoryAddPopup(context);
                                          },
                                          icon: const Icon(
                                            Icons.add_box_outlined,
                                            color: Color.fromARGB(
                                                255, 35, 45, 255),
                                          )),
                                    ])),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: Text(
                                    _selectedCategoryMessages,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ),
                                ),
                                const Text(
                                  "Amount",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  // ignore: body_might_complete_normally_nullable
                                  validator: ((value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  }),
                                  controller: _amountTextEditingController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      filled: true),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "Notes",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter notes";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  minLines: 3,
                                  controller: _notesTextEditingController,
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      filled: true),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Consumer<TransactionDB>(
                                    builder: ((context, value, child) =>
                                        TextFormField(
                                          readOnly: true,
                                          onTap: () async {
                                            final selectedDateTemp =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(
                                                      const Duration(days: 30)),
                                              lastDate: DateTime.now(),
                                            );
                                            if (selectedDateTemp == null) {
                                              return;
                                            } else {
                                              value.selectedDate =
                                                  selectedDateTemp;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText:
                                                  (value.selectedDate == null
                                                      ? "Select Date"
                                                      : parseDate(
                                                          value.selectedDate!)),
                                              prefixIcon: const Icon(
                                                  Icons.calendar_month),
                                              isDense: true,
                                              fillColor: Colors.white,
                                              border:
                                                  const OutlineInputBorder(),
                                              filled: true),
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 9, bottom: 3),
                                  child: Text(
                                    _selectedDateMessages,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 180,
                                    child: Consumer<TransactionDB>(
                                      builder: (context, value, child) =>
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)))),
                                              onPressed: () {
                                                if (_selectedCategoryModel ==
                                                    null) {
                                                  _selectedCategoryMessages =
                                                      "Please select Category";
                                                }
                                                if (value.selectedDate ==
                                                    null) {
                                                  _selectedDateMessages =
                                                      "Please select date";
                                                }
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  addTransaction(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  1000),
                                                          content: Text(
                                                              "Transaction added")));
                                                }
                                              },
                                              child: const Text("Add")),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                kIsWeb
                                    ? Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Exit")),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction(context) async {
    final notesText = _notesTextEditingController.text;
    final amountText = _amountTextEditingController.text;

    if (notesText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (Provider.of<TransactionDB>(context, listen: false).selectedDate ==
        null) {
      return;
    }
    final parseAmount = double.tryParse(amountText);
    if (parseAmount == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    // ignore: unused_local_variable
    final model = TransactionModel(
      notes: notesText,
      amount: parseAmount,
      date: Provider.of<TransactionDB>(context, listen: false).selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    await TransactionDB.instance.addTransaction(model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMEd().format(date);
  }
}
