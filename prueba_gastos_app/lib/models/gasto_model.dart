//import 'dart:convert';


class Gasto{
  final int? id;
  final String usuario;
  final String categoria;
  final double monto;
  final DateTime fecha;

  Gasto({this.id, required this.usuario, required this.categoria, required this.monto, required this.fecha});

  factory Gasto.fromJson(Map<String, dynamic> json){
    return Gasto(
      id: json['id'], 
      usuario: json['usuario'], 
      categoria: json['categoria'],
      monto: json['monto'].toDouble(), 
      fecha: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'usuario':usuario, 
      'categoria': categoria, 
      'monto': monto, 
      'fecha': fecha.toIso8601String(),
    };
  }
}