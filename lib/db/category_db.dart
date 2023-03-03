// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/models/category_modal.dart';

// abstract class CategoryDbFunctions {
//   Future<List<CategoryModel>> getCategories();
//   Future<void> insertCategory(CategoryModel value);
//   Future<void> deleteCategoty(String categoryID);
// }

class CategoryDB with ChangeNotifier {
  final CATEGORY_DB_NAME = 'category-database';

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  // ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
  //     ValueNotifier([]);
  // ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
  //     ValueNotifier([]);

  List<CategoryModel> incomeCategoryListListener = [];
  List<CategoryModel> expenseCategoryListListener = [];

  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUi();
  }

  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUi() async {
    incomeCategoryListListener.clear();
    expenseCategoryListListener.clear();
    final _allCategory = await getCategories();
    await Future.forEach(
      _allCategory,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.add(category);
        } else {
          expenseCategoryListListener.add(category);
        }
      },
    );

    notifyListeners();
  }

  Future<void> deleteCategoty(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUi();
  }
}
