import 'api_service.dart';

class TimetableService {
  static Future<Map<String, dynamic>> getTimetable(int userId) async {
    return await ApiService.get("timetable/read.php?user_id=$userId");
  }

  static Future<Map<String, dynamic>> createClass(Map<String, dynamic> data) async {
    return await ApiService.post("timetable/create.php", data);
  }

  static Future<Map<String, dynamic>> deleteClass(int id) async {
    return await ApiService.post("timetable/delete.php", {"id": id});
  }
}
