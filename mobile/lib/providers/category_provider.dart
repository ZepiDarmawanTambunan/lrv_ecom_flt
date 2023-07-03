
import 'package:flutter/material.dart';
import 'package:mobile/models/category_model.dart';
import 'package:mobile/services/category_service.dart';

class CategoryProvider with ChangeNotifier{
  List<CategoryModel> _categories = [];
  int? _selectedCategory;

  List<CategoryModel> get categories => _categories;
  int get selectedCategory => _selectedCategory ?? 1;

  set categories(List<CategoryModel> categories){
    _categories = categories;
    _selectedCategory = (_categories.length > 0) ? _categories[0].id : 1;
    notifyListeners();
  }

  set selectedCategory(int selectedId) {
    _selectedCategory = selectedId;
    notifyListeners();
  }

  Future<void> getcategories()async{
    try {
      List<CategoryModel> result = await CategoryService().getCategories();
      categories = result;
    } catch (e) {
      print(e);
    }
  }
}