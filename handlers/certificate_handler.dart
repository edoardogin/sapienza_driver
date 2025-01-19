import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapienza_driver/models/certificates.dart';

class CertificateHandler {
  final String endpoint = "https://www.studenti.uniroma1.it/phxdroidws/";
  final String token;

  CertificateHandler({required this.token});

  Future<String> getCertificate(String studentID, CertificateType type) async {
    try {
      final certificateCode = getCertificateValue(type);
      if (certificateCode == -1) {
        throw Exception('Tipo di certificato non valido.');
      }

      final url = Uri.parse(
          '$endpoint/certificati/corsodilaurea/$studentID/$certificateCode/it/?ingresso=$token&codiceDidattica=1');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Verifica se la risposta contiene i dati attesi
        final result = data['risultato']?['result']?['documentServerResultDTO'];
        if (result == null || result['pdf_file_http_path'] == null) {
          throw Exception('Nessun link al certificato trovato nella risposta.');
        }

        return result['pdf_file_http_path']; // Restituisci il link al PDF
      } else {
        throw Exception(
            'Errore nella richiesta: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero del certificato: $e');
    }
  }
}
