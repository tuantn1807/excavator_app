import '../models/pagination_model.dart';
import '../models/product_model.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient apiClient;

  ProductService(this.apiClient);

  Future<PaginatedResponse<ProductModel>> getProducts({
    int page = 1,
    int? categoryId,
  }) async {
    final Map<String, dynamic> query = {'page': page};
    if (categoryId != null) {
      query['category_id'] = categoryId;
    }
    final response = await apiClient.get('/products', queryParameters: query);
    return PaginatedResponse.fromJson(
      response.data,
      (json) => ProductModel.fromJson(json),
    );
  }

  Future<ProductModel> getProductDetail(int id) async {
    final response = await apiClient.get('/products/$id');
    return ProductModel.fromJson(response.data);
  }
}
