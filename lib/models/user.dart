import 'dart:convert';

class User {
  final int? usrId;
  final String? fullName;
  final String? email;
  final String usrName;
  final String password;

  User({
    this.usrId,
    this.fullName,
    this.email,
    required this.usrName,
    required this.password,
  });

  // Factory method para convertir un mapa en una instancia de Users
  factory User.fromMap(Map<String, dynamic> json) => User(
        usrId: json["usrId"],
        fullName: json["fullName"],
        email: json["email"],
        usrName: json["usrName"],
        password: json["usrPassword"],
      );

  // Método para convertir una instancia de Users en un mapa
  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "fullName": fullName,
        "email": email,
        "usrName": usrName,
        "usrPassword": password,
      };
}
