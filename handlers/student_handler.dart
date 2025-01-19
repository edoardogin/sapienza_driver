import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class StudentHandler {
  final String endpoint = "https://www.studenti.uniroma1.it/phxdroidws/";
  final String token;

  StudentHandler({required this.token});

  /// Recupera le informazioni dello studente tramite API REST
  Future<Student> getStudentInfo(String studentID) async {
    // Costruzione dell'URL
    final url = Uri.parse('$endpoint/studente/$studentID?ingresso=$token');

    // Effettua la richiesta HTTP
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    // Gestisce la risposta
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['ritorno'] != null) {
        return Student.fromJson(data['ritorno']);
      } else {
        throw Exception('Risposta API non valida: manca il campo "ritorno".');
      }
    } else {
      throw Exception('Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}