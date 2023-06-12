// ignore_for_file: no_leading_underscores_for_local_identifiers, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:money_manager_app/controller/category_db.dart';
import 'package:money_manager_app/models/category_modal.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context,
    {CategoryType? categoryType}) async {
  final _nameEditingController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text("Add Category"),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a category";
                    }
                  },
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                    label: Text("add Category"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            categoryType != null
                ? const SizedBox()
                : const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        RadioButton(title: "income", type: CategoryType.income),
                        RadioButton(
                            title: "Expense", type: CategoryType.expense),
                      ],
                    )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text.trim();
                  if (_formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          duration: Duration(milliseconds: 800),
                          content: Text('Category added')),
                    );
                  }

                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = categoryType ?? selectedCategoryNotifier.value;
                  final _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _name,
                      type: _type);
                  CategoryDB().insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: const Text("Add"),
              ),
            )
          ],
        );
      });
}

// ignore: must_be_immutable
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: selectedCategoryNotifier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
