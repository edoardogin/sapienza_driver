import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapienza_driver/models/doable_exam.dart';
import 'package:sapienza_driver/models/reservedexam.dart';
import 'package:sapienza_driver/models/student.dart';

class ExamReservationHandler {
  final String endpoint = "https://www.studenti.uniroma1.it/phxdroidws/";
  final String token;

  ExamReservationHandler({required this.token});

  Future<Map<String, dynamic>> insertReservation({
    required String reportID,
    required String sessionID,
    required String courseCode,
  }) async {
    try {
      final url = Uri.parse('$endpoint/prenotazione/$reportID/$sessionID/$courseCode/1/?ingresso=$token');

      // In Dart, il body può essere vuoto se non richiesto esplicitamente
      final response = await http.post(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        print(data);

        int flag = -1;
        String? nota;
        String? url;

        if (data.containsKey('esito')) {
          final esito = data['esito'] as Map<String, dynamic>;

          if (esito.containsKey('flagEsito')) {
            flag = esito['flagEsito'];
          }

          if (esito.containsKey('nota') && esito['nota'] != null) {
            nota = esito['nota'];
          }
        }

        if (data.containsKey('urlOpis') && data['urlOpis'] != null) {
          url = data['urlOpis'];
        } else if (data.containsKey('url') && data['url'] != null) {
          url = data['url'];
        }

        if (url == null && flag != 0 && (nota == null || !nota.contains("già prenotato"))) {
          throw Exception('Prenotazione non riuscita: $nota');
        }

        return {
          'flag': flag,
          'url': url,
        };
      } else {
        print(response.body);
        throw Exception('Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Errore durante l\'inserimento della prenotazione: $e');
    }
  }

  Future<List<ReservedExam>> getAvailableReservations(DoableExam exam, Student student) async {
    try {
      final url = Uri.parse(
        '$endpoint/appello/ricerca?ingresso=$token&tipoRicerca=4&criterio=${exam.codiceModuloDidattico}&codiceCorso=${exam.codiceCorsoInsegnamento}&annoAccaAuto=${student.annoAccademicoAttuale}',
      );

      final response = await http.get(url, headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (!data.containsKey('ritorno') || data['ritorno'] == null) {
          throw Exception('Risposta non valida: manca il campo "ritorno".');
        }

        final ritorno = data['ritorno'];

        if (!ritorno.containsKey('appelli') || ritorno['appelli'] == null) {
          return [];
        }

        final List<dynamic> appelliJson = ritorno['appelli'];
        return appelliJson.map((e) => ReservedExam.fromJson(e)).toList();
      } else {
        throw Exception('Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero delle prenotazioni disponibili: $e');
    }
  }
}
