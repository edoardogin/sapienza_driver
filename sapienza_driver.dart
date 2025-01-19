import 'handlers/auth_handler.dart';
import 'handlers/exam_handler.dart';

class SapienzaDriver {
  String? token;

  late AuthHandler authHandler;
  late ExamHandler examHandler;

  SapienzaDriver() {
    authHandler = AuthHandler();
  }

  Future<void> login(String studentID, String password) async {
    await authHandler.login(studentID, password);
    token = authHandler.token;
    if (token == null) throw Exception('Token non valido');
    examHandler = ExamHandler(token: token!);
  }
}
