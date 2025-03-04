import 'package:flutter/material.dart';
import 'package:prueba_gastos_app/screens/home_screen.dart';
import 'package:prueba_gastos_app/services/auth_service.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //variables
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  //funciones
  login() async {
    bool success = await _authService.login(_usernameController.text, _passwordController.text);
    if(success){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error en autenticacion")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Iniciar Sesion")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Usuario")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            SizedBox(height: 20), 
            ElevatedButton(onPressed: login, child: Text("Iniciar Sesión")),
          ],
        ),
      ),
    );
  }
}