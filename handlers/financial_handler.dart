
import 'dart:convert';

import 'package:sapienza_driver/models/isee.dart';
import 'package:sapienza_driver/models/tax.dart';
import 'package:http/http.dart' as http;

class TaxHandler {
  final String endpoint = "https://www.studenti.uniroma1.it/phxdroidws/";
  final String token;

  TaxHandler({required this.token});

  Future<List<Tax>> getTaxes(bool isPaid, String studentID) async {
    try {
      final String path = isPaid ? 'bollettinipagati' : 'bollettininonpagati';
      final url = Uri.parse('$endpoint/contabilita/$studentID/$path?ingresso=$token');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['risultatoLista']?['risultati'] as List<dynamic>?;

        print(results);
        if (results == null) {
          throw Exception('Nessuna tassa trovata.');
        }

        return results.map((e) => Tax.fromJson(e)).toList();
      } else {
        throw Exception('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero delle tasse: $e');
    }
  }

  Future<List<Tax>> getPaidTaxes(String studentID) async {
    return getTaxes(true, studentID);
  }

  Future<List<Tax>> getUnpaidTaxes(String studentID) async {
    return getTaxes(false, studentID);
  }

  Future<Isee> getCurrentIsee(String studentID) async {
    try {
      final url = Uri.parse('$endpoint/contabilita/$studentID/isee?ingresso=$token');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final iseeData = data['risultato'];
        if (iseeData == null) {
          throw Exception('Nessun ISEE corrente trovato.');
        }
        return Isee.fromJson(iseeData);
      } else {
        throw Exception('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero dell\'ISEE: $e');
    }
  }

  Future<List<Isee>> getIseeHistory(String studentID) async {
  
    try {
      final url = Uri.parse('$endpoint/contabilita/$studentID/listaIsee?ingresso=$token');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['risultatoLista']?['risultati'] as List<dynamic>?;

        if (results == null) {
          throw Exception('Nessuna storia ISEE trovata.');
        }

        return results.map((e) => Isee.fromJson(e)).toList();
      } else {
        throw Exception('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero della storia ISEE: $e');
    }
  }

  Future<String> getPaymentSlipPDF(String studentID, String taxCode) async {
    try {
      final url = Uri.parse('$endpoint/contabilita/$studentID/$taxCode/ristampa?ingresso=$token');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final pdfPath = data['risultato']?['pdf_file_http_path'];
        if (pdfPath == null) {
          throw Exception('Nessun PDF trovato per la tassa.');
        }

        return pdfPath;
      } else {
        throw Exception('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore durante il recupero del PDF: $e');
    }
  }
}
