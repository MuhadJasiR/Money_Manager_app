// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

// ignore: must_be_immutable
class EditTransactionScreen extends StatefulWidget {
  EditTransactionScreen({
    super.key,
    required this.obj,
    required this.id,
  });
  String? id;
  TransactionModel obj;

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formkey = GlobalKey<FormState>();
  String _selectedDateMessages = '';
  String _selectedCategoryMessages = '';
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  TextEditingController _notesTextEditingController = TextEditingController();
  TextEditingController _amountTextEditingController = TextEditingController();
  List<bool> _selectTranscationType = <bool>[true, false];
  String? _categoryId;
  var selectedType;
  @override
  void initState() {
    CategoryDB.instance.expenseCategoryListListener;
    CategoryDB.instance.incomeCategoryListListener;
    super.initState();
    _amountTextEditingController =
        TextEditingController(text: widget.obj.amount.toString());
    _notesTextEditingController = TextEditingController(text: widget.obj.notes);
    _selectedDate = widget.obj.date;
    _selectedCategoryType = widget.obj.category.type;
    _selectedCategoryModel = widget.obj.category;
    _categoryId = widget.obj.category.id;
    _selectTranscationType = widget.obj.category.type == CategoryType.income
        ? [true, false]
        : [false, true];
    selectedType = _selectedCategoryType == CategoryType.income ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
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
                      "Edit Transaction",
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
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 70),
                                  child: ToggleButtons(
                                    // direction: Axis.horizontal,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0;
                                            i < _selectTranscationType.length;
                                            i++) {
                                          _selectTranscationType[i] =
                                              i == index;
                                          selectedType = index;
                                          _categoryId = null;
                                        }
                                      });
                                    },
                                    color: const Color.fromARGB(
                                        255, 128, 128, 128),
                                    borderColor:
                                        const Color.fromARGB(255, 45, 35, 255),
                                    borderRadius: BorderRadius.circular(25),
                                    selectedBorderColor:
                                        const Color.fromARGB(255, 35, 43, 255),
                                    selectedColor: Colors.white,
                                    fillColor:
                                        const Color.fromARGB(255, 35, 43, 255),
                                    constraints: const BoxConstraints(
                                        minHeight: 30, minWidth: 85),
                                    isSelected: _selectTranscationType,
                                    children: transactionType,
                                  ),
                                ),
                                const SizedBox(height: 8),
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
                                      label: Text("Enter Amount"),
                                      border: OutlineInputBorder(),
                                      filled: true),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: kIsWeb ? 1800 : 285,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black54),
                                          ),
                                          child: Consumer<CategoryDB>(builder:
                                              ((context, value, child) {
                                            return DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                value: _categoryId,
                                                items: (selectedType == 1
                                                        ? value
                                                            .expenseCategoryListListener
                                                        : value
                                                            .incomeCategoryListListener)
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    value: e.id,
                                                    child: Text("   ${e.name}"),
                                                    onTap: () {
                                                      _selectedCategoryModel =
                                                          e;
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (selectedValue) {
                                                  setState(() {
                                                    _categoryId = selectedValue;
                                                  });
                                                },
                                              ),
                                            );
                                          }))),
                                      IconButton(
                                          onPressed: () {
                                            showCategoryAddPopup(context);
                                          },
                                          icon: const Icon(
                                            Icons.add_box_outlined,
                                            color: Color.fromARGB(
                                                255, 35, 45, 255),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _selectedCategoryMessages,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Notes",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter notes";
                                    }
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                  minLines: 2,
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
                                TextFormField(
                                  readOnly: true,
                                  onTap: () async {
                                    final selectedDateTemp =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 30)),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDateTemp == null) {
                                      return;
                                    } else {
                                      setState(() {
                                        _selectedDate = selectedDateTemp;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: (_selectedDate == null
                                          ? "Select Date"
                                          : parseDate(_selectedDate!)),
                                      prefixIcon:
                                          const Icon(Icons.calendar_month),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(),
                                      filled: true),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 111),
                                  child: Text(
                                    _selectedDateMessages,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 180,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
                                        onPressed: () {
                                          if (_selectedCategoryModel == null) {
                                            setState(() {
                                              _selectedCategoryMessages =
                                                  "Please select Category";
                                            });
                                          }
                                          if (_selectedDate == null) {
                                            setState(() {
                                              _selectedDateMessages =
                                                  "Please select date";
                                            });
                                          }
                                          if (_formkey.currentState!
                                              .validate()) {
                                            editTransaction();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 1200),
                                                    content: Text(
                                                        "Transaction edited")));
                                          }
                                        },
                                        child: const Text("Update")),
                                  ),
                                ),
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

  Future<void> editTransaction() async {
    final notesText = _notesTextEditingController.text;
    final amountText = _amountTextEditingController.text;

    if (notesText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
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
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
      id: widget.obj.id,
    );

    await TransactionDB.instance.updateTransactionModel(model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }

  String parseDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}
