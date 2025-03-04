import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prueba_gastos_app/bloc/gasto_bloc.dart';
import 'package:prueba_gastos_app/screens/nuevo_gasto_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gastos")),
      body: BlocBuilder<GastoBloc, GastoState>(
        builder: (context, state) {
          if(state is GastoInicial) {
            context.read<GastoBloc>().add(CargarGastos());
            return Center(child: CircularProgressIndicator());
          } else if (state is GastosCargados) {
            return ListView.builder(
              itemCount: state.gastos.length,
              itemBuilder: (context, index) {
                final gasto = state.gastos[index];
                return ListTile(
                  title: Text("${gasto.usuario} - ${gasto.categoria}"),
                  subtitle: Text("${gasto.monto} - ${DateFormat.yMd().format(gasto.fecha)}"),
                );
              },
            );
          }else if (state is GastoError) {
            return Center(child: Text(state.mensaje));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NuevoGastoScreen())),
      ),
    );
  }
}