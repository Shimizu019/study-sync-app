import 'api_service.dart';

class SessionService {
  static Future<Map<String, dynamic>> startSession(Map<String, dynamic> data) async {
    return await ApiService.post("sessions/start.php", data);
  }

  static Future<Map<String, dynamic>> endSession(int sessionId, int durationMinutes) async {
    return await ApiService.post("sessions/end.php", {
      "session_id": sessionId,
      "duration_minutes": durationMinutes,
    });
  }
}
