import '../models/category_model.dart';
import 'api_client.dart';

class CategoryService {
  final ApiClient apiClient;

  CategoryService(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.get('/categories');

    // Laravel có thể trả về List trực tiếp hoặc Object Paginate {"data": [...]}
    dynamic data = response.data;
    if (data is Map && data.containsKey('data')) {
      data = data['data'];
    }

    if (data is List) {
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<CategoryModel> getCategoryDetail(int id) async {
    final response = await apiClient.get('/categories/$id');
    return CategoryModel.fromJson(response.data);
  }
}
