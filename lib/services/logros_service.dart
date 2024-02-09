import 'dart:convert';
import 'package:http/http.dart' as http;

class LogrosService {
  static Future<List<dynamic>> getLogros() async {
    final url = 'http://10.0.2.2:8000/api/logro'; // URL del endpoint del backend

    try {
      final response = await http.get(Uri.parse(url));
        
      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, devuelve los datos decodificados
        return json.decode(response.body);
      } else {
        // Si la solicitud falló, maneja el error
        throw Exception('Error al obtener logros: ${response.statusCode}');
      }
    } catch (e) {
      // Error de conexión u otro error
      throw Exception('Error: $e');
    }
  }
}
