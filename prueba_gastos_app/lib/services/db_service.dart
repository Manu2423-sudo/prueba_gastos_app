import 'package:prueba_gastos_app/models/gasto_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gastos.db');

    return await openDatabase(
      path, 
      version: 1, 
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE gastos(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              usuario TEXT, 
              categoria TEXT, 
              monto REAL, 
              fecha TEXT
            )
       ''');
      },
    );
  }

  Future<void> insertGasto(Gasto gasto) async {
    final db = await database;
    await db.insert('gastos', gasto.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Gasto>> getGastos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('gastos');

    return List.generate(maps.length, (i) {
      return Gasto.fromJson(maps[i]);
    });
  }
}