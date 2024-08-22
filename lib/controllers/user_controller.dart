import '../services/api_service.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class UserController {
  final ApiService _apiService = ApiService();

  Future<List<User>> getUsers() async {
    final response = await _apiService.get('${Constants.apiBaseUrl}/users');
    if (response?.statusCode == 200) {
      final List<dynamic> data = response?.data['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<User?> getUser(int userId) async {
    final response =
        await _apiService.get('${Constants.apiBaseUrl}/users/$userId');
    if (response?.statusCode == 200) {
      return User.fromJson(response?.data['data']);
    } else {
      return null;
    }
  }
}
