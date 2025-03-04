import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_gastos_app/models/gasto_model.dart';
import 'package:prueba_gastos_app/services/db_service.dart';
import 'package:prueba_gastos_app/services/gasto_service.dart';

//Eventos
abstract class GastoEvent{}
class CargarGastos extends GastoEvent {}

class AgregarGasto extends GastoEvent {
  final Gasto gasto;
  AgregarGasto(this.gasto);
}


// Estado de gastos
abstract class GastoState {}
class GastoInicial extends GastoState {}

class GastosCargados extends GastoState{
  final List<Gasto> gastos;
  GastosCargados(this.gastos);
}
class GastoError extends GastoState{
  final String mensaje;
  GastoError(this.mensaje);
}


//Bloc
class GastoBloc extends Bloc<GastoEvent, GastoState>{
  final GastoService gastoService;
  final DBService dbService;

  GastoBloc(this.gastoService, this.dbService) : super(GastoInicial()) {
    on<CargarGastos>((event, emit) async {
      try {
        final gastos = await gastoService.obtenerGastos();
        await Future.forEach(gastos, (gasto) async => await dbService.insertGasto(gasto));
        emit(GastosCargados(gastos));
      } catch (e) {
        final gastosOffline = await dbService.getGastos();
        emit(GastosCargados(gastosOffline));
      }
    });

    on<AgregarGasto>((event, emit) async {
      try {
        await gastoService.agregarGasto(event.gasto);
      }catch (e) {
        await dbService.insertGasto(event.gasto);
      }
      final gastosOffline = await dbService.getGastos();
      emit(GastosCargados(gastosOffline));
    });
  }
}
