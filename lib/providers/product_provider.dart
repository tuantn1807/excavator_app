import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService productService;
  List<ProductModel> _products = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;

  ProductProvider(this.productService);

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchProducts({bool refresh = false, int? categoryId}) async {
    if (refresh) {
      _currentPage = 1;
      _products = [];
      _hasMore = true;
    }
    if (!_hasMore || (_isLoading && !refresh)) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await productService.getProducts(
        page: _currentPage,
        categoryId: categoryId,
      );
      _products.addAll(response.data);
      _currentPage++;
      _hasMore = response.currentPage < response.lastPage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ProductModel> getProductDetail(int id) async {
    return await productService.getProductDetail(id);
  }
}
