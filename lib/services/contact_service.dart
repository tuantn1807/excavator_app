import 'api_client.dart';

class ContactService {
  final ApiClient apiClient;

  ContactService(this.apiClient);

  Future<Map<String, dynamic>> sendContact({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    final response = await apiClient.post(
      '/contact',
      data: {'name': name, 'email': email, 'phone': phone, 'message': message},
    );
    return response.data;
  }
}
