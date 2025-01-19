import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthHandler {
  final String endpoint = "https://www.studenti.uniroma1.it/phxdroidws/";
  String? token;

  AuthHandler();

  /// Metodo per autenticarsi e ottenere il token.
  Future<String?> login(String studentID, String password) async {
    final response = await http.post(
      Uri.parse('$endpoint/autenticazione'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'key': "r4g4zz3tt1",
        'matricola': studentID,
        'stringaAutenticazione': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      token = data['output'];
      return token;
    } else {
      throw Exception('Errore nella richiesta: ${response.statusCode}');
    }
  }

  /// Metodo per annullare l'autenticazione (logout).
  Future<void> logout() async {
    if (token == null) {
      throw Exception('Nessun token presente. Effettua il login prima di eseguire il logout.');
    }

    final response = await http.post(
      Uri.parse('$endpoint/logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      token = null; // Reset del token
    } else {
      throw Exception('Errore durante il logout: ${response.statusCode}');
    }
  }

  /// Metodo per verificare se il token è valido.
  Future<bool> isTokenValid() async {
    if (token == null) return false;

    final response = await http.get(
      Uri.parse('$endpoint/validate'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response.statusCode == 200;
  }
}
