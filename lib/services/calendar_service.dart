import 'api_service.dart';

class CalendarService {
  static Future<Map<String, dynamic>> getCalendarData(int userId) async {
    return await ApiService.get("calendar/read.php?user_id=$userId");
  }
}
