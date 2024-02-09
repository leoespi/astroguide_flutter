import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:astroguide_flutter/pages/login.dart';
import 'package:astroguide_flutter/pages/profile.dart';


class UserService {
  static final String baseUrl = 'http://127.0.0.1:8000'; // Reemplaza con la URL de tu servidor

  static Future<bool> authenticate(String usrName, String password) async {
    try {
      final url = '$baseUrl/authenticate.php';
      final response = await http.post(Uri.parse(url), body: {
        'usrName': usrName,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.body == 'true';
      } else {
        throw Exception('Error al autenticar usuario: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  static Future<bool> register(String fullName, String email, String usrName, String password) async {
    try {
      final url = '$baseUrl/signup.php';
      final response = await http.post(Uri.parse(url), body: {
        'fullName': fullName,
        'email': email,
        'usrName': usrName,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.body == 'true';
      } else {
        throw Exception('Error al registrar usuario: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  static Future<List<dynamic>> obtenerUsuarios() async {
    try {
      final url = '$baseUrl/user';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener usuarios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  static getUserDetails(String text) {}

  static logout() {}
}
