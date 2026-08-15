import 'api_service.dart';

class TaskService {
  static Future<Map<String, dynamic>> getTasks(int userId, {String? status}) async {
    String endpoint = "tasks/read.php?user_id=$userId";
    if (status != null) endpoint += "&status=$status";
    return await ApiService.get(endpoint);
  }

  static Future<Map<String, dynamic>> createTask(Map<String, dynamic> data) async {
    return await ApiService.post("tasks/create.php", data);
  }

  static Future<Map<String, dynamic>> updateTask(Map<String, dynamic> data) async {
    return await ApiService.post("tasks/update.php", data);
  }
}
