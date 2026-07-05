import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService productService;
  List<ProductModel> _products = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;
  int _fetchId = 0;

  ProductProvider(this.productService);

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchProducts({bool refresh = false, int? categoryId}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      // We don't clear _products here immediately to avoid empty flashes if another request is inflight,
      // but if we do, it's fine. We'll clear it when we receive the data.
    }
    
    if (!_hasMore || (_isLoading && !refresh)) return;

    final currentFetchId = ++_fetchId;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await productService.getProducts(
        page: _currentPage,
        categoryId: categoryId,
      );

      // Bỏ qua nếu có request mới hơn đã được gọi
      if (currentFetchId != _fetchId) return;

      if (refresh) {
        _products.clear();
      }
      
      _products.addAll(response.data);
      _currentPage++;
      _hasMore = response.currentPage < response.lastPage;
    } finally {
      if (currentFetchId == _fetchId) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<ProductModel> getProductDetail(int id) async {
    return await productService.getProductDetail(id);
  }
}
