import 'api_service.dart';

class ProfileService {
  static Future<Map<String, dynamic>> getProfile(int userId) async {
    return await ApiService.get("profile/get.php?user_id=$userId");
  }
}
