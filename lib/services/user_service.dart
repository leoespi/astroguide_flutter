import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static Future<List<dynamic>> obtenerUsuarios() async {
    final url = 'http://10.0.2.2:8000/api/user'; // Reemplaza con tu propia URL de la API Laravel
    try {
      
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, devuelve los datos decodificados
        return json.decode(response.body);
      } else {
        // La solicitud falló, maneja el error de otra manera
        throw Exception('Error al obtener usuarios: ${response.statusCode}');
      }
    } catch (e) {
      // Error de conexión u otro error
      throw Exception('Error: $e');
    }
  }

  
}
