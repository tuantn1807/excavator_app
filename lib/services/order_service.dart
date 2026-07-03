import '../models/order_model.dart';
import '../models/pagination_model.dart';
import 'api_client.dart';

class OrderService {
  final ApiClient apiClient;

  OrderService(this.apiClient);

  Future<OrderModel> createOrder({
    required String name,
    required String phone,
    required String email,
    required String address,
    String? note,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await apiClient.post(
      '/orders',
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        'note': note,
        'items': items,
      },
    );
    return OrderModel.fromJson(response.data['order']);
  }

  Future<PaginatedResponse<OrderModel>> getMyOrders({int page = 1}) async {
    final response = await apiClient.get(
      '/orders',
      queryParameters: {'page': page},
    );
    return PaginatedResponse.fromJson(
      response.data,
      (json) => OrderModel.fromJson(json),
    );
  }

  Future<OrderModel> getOrderDetail(int id) async {
    final response = await apiClient.get('/orders/$id');
    return OrderModel.fromJson(response.data);
  }
}
