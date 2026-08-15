import 'api_service.dart';

class SubjectService {
  static Future<Map<String, dynamic>> getSubjects(int userId) async {
    return await ApiService.get("subjects/read.php?user_id=$userId");
  }

  static Future<Map<String, dynamic>> createSubject(Map<String, dynamic> data) async {
    return await ApiService.post("subjects/create.php", data);
  }

  static Future<Map<String, dynamic>> deleteSubject(int id) async {
    return await ApiService.post("subjects/delete.php", {"id": id});
  }
}
