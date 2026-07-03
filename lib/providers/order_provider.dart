import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService orderService;
  List<OrderModel> _orders = [];
  bool _isLoading = false;

  OrderProvider(this.orderService);

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> fetchMyOrders() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await orderService.getMyOrders();
      _orders = response.data;
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<OrderModel> createOrder({
    required String name,
    required String phone,
    required String email,
    required String address,
    String? note,
    required List<Map<String, dynamic>> items,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      return await orderService.createOrder(
        name: name,
        phone: phone,
        email: email,
        address: address,
        note: note,
        items: items,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
