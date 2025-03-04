import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_gastos_app/bloc/gasto_bloc.dart';
import 'package:prueba_gastos_app/models/gasto_model.dart';

class NuevoGastoScreen extends StatefulWidget {
  @override
  State<NuevoGastoScreen> createState() => _NuevoGastoScreenState();
}

class _NuevoGastoScreenState extends State<NuevoGastoScreen> {
  //Variables
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _montoController = TextEditingController();

  //metodo

  guardarGasto(){
    if(_formKey.currentState!.validate()) {
      final gasto = Gasto(
        usuario: _usuarioController.text, 
        categoria: _categoriaController.text, 
        monto: double.parse(_montoController.text), 
        fecha: DateTime.now(),
      );
      context.read<GastoBloc>().add(AgregarGasto(gasto));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo Gasto")),
      body: Padding(
        padding: EdgeInsets.all(16.0), 
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(labelText: "Usuario"),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: "Categoria"),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              TextFormField(
                controller: _montoController,
                decoration: InputDecoration(labelText: "Monto"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value!.isEmpty) return "Campo obligatorio";
                  if(double.tryParse(value) == null || double.parse(value) <= 0) return "Monto inválido";
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: guardarGasto, child: Text("Guardar")),
            ],
          ), 
        ),
      ),
    );
  }
}