import '../models/pagination_model.dart';
import '../models/post_model.dart';
import 'api_client.dart';

class PostService {
  final ApiClient apiClient;

  PostService(this.apiClient);

  Future<PaginatedResponse<PostModel>> getPosts({int page = 1}) async {
    final response = await apiClient.get(
      '/posts',
      queryParameters: {'page': page},
    );
    return PaginatedResponse.fromJson(
      response.data,
      (json) => PostModel.fromJson(json),
    );
  }

  Future<PostModel> getPostDetail(int id) async {
    final response = await apiClient.get('/posts/$id');
    return PostModel.fromJson(response.data);
  }
}
