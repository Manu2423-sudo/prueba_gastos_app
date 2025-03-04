import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_gastos_app/models/gasto_model.dart';

class GastoService {
  final String baseUrl = "Url";
  
  Future<List<Gasto>> obtenerGastos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Gasto.fromJson(json)).toList();
    }else {
      throw Exception("Error al cargar gastos");
    }
  }

  Future<void> agregarGasto(Gasto gasto) async {
    final response = await http.post(
      Uri.parse(baseUrl), 
      headers: {'Content-Type': 'application/json'}, 
      body: json.encode(gasto.toJson()),
    );

    if(response.statusCode != 200){
      throw Exception("Error al agregar la canntidad del gasto");
    }
  }
}