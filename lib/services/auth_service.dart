import 'api_service.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    return await ApiService.post("auth/login.php", {
      "email": email,
      "password": password,
    });
  }

  static Future<Map<String, dynamic>> signup(String fullName, String email, String password) async {
    return await ApiService.post("auth/signup.php", {
      "full_name": fullName,
      "email": email,
      "password": password,
    });
  }
}