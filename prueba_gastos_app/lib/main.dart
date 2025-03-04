import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_gastos_app/bloc/gasto_bloc.dart';
import 'package:prueba_gastos_app/services/gasto_service.dart';
import 'package:prueba_gastos_app/services/db_service.dart';
import 'package:prueba_gastos_app/services/auth_service.dart';
import 'package:prueba_gastos_app/screens/home_screen.dart';
import 'package:prueba_gastos_app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final isLoggedIn = await authService.isLogIn();
  
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GastoBloc(GastoService(), DBService()), 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Control de gastos',
        home: isLoggedIn ? HomeScreen() : LoginScreen(),
      ), 
    );
  }
}
