import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapienza_driver/models/doable_exam.dart';
import 'package:sapienza_driver/models/reservedexam.dart';
import '../models/exam.dart';

class ExamHandler {
  final String endpoint = "https://www.studenti.uniroma1.it/phxdroidws/";
  final String token;

  ExamHandler({required this.token});

  /// Recupera gli esami già sostenuti
  Future<List<Exam>> getExamsDone(String studentID) async {
    try {
      final url = Uri.parse('$endpoint/studente/$studentID/esamiall?ingresso=$token');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data['ritorno'] == null || data['ritorno']['esami'] == null) {
          throw Exception('Nessun dato trovato nella risposta.');
        }

        final List<dynamic> examsJson = data['ritorno']['esami'] as List;
        return examsJson.map((e) => Exam.fromJson(e)).toList();
      } else {
        throw Exception('Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero degli esami sostenuti: $e');
    }
  }
Future<List<ReservedExam>> getReservedExams(String studentID) async {
  try {
    final url = Uri.parse('$endpoint/studente/$studentID/prenotazioni?ingresso=$token');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['ritorno'] == null || data['ritorno']['appelli'] == null) {
        throw Exception('Nessun dato trovato nella risposta.');
      }

      final List<dynamic> reservedExamsJson = data['ritorno']['appelli'] as List;
      return reservedExamsJson.map((e) => ReservedExam.fromJson(e)).toList();
    } else {
      throw Exception('Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Errore durante il recupero degli esami prenotati: $e');
  }
}
Future<List<DoableExam>> getDoableExams(String studentID) async {
  try {
    final url = Uri.parse(
        '$endpoint/studente/$studentID/insegnamentisostenibili?ingresso=$token');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['ritorno'] == null || data['ritorno']['esami'] == null) {
        throw Exception('Nessun dato trovato nella risposta.');
      }

      final List<dynamic> doableExamsJson = data['ritorno']['esami'] as List;
      return doableExamsJson.map((e) => DoableExam.fromJson(e)).toList();
    } else {
      throw Exception(
          'Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Errore durante il recupero degli esami prenotabili: $e');
  }
}

}