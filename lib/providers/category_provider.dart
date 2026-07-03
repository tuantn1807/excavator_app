import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService categoryService;
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  CategoryProvider(this.categoryService);

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await categoryService.getCategories();
    } catch (e) {
      print('Lỗi fetchCategories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
