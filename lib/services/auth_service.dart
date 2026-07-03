import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<AuthResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await apiClient.post(
      '/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data);
  }

  Future<AuthResponseModel> login(String email, String password) async {
    final response = await apiClient.post(
      '/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data);
  }

  Future<UserModel> me() async {
    final response = await apiClient.get('/me');
    return UserModel.fromJson(response.data);
  }

  Future<void> logout() async {
    await apiClient.post('/logout');
  }
}
