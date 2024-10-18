
import 'package:sqflite/sqflite.dart';
import 'package:calculadora/DatabaseHelper.dart';
import 'package:calculadora/Auto.dart';

class Carrodao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertAuto(Carro auto) async{
    final db = await _dbHelper.database;
    await db.insert('auto', auto.toMap());
    conflictAlgorithm: ConflictAlgorithm.replace;
  }

  Future<void> updateAuto(Carro auto) async {
    final db = await _dbHelper.database;
    await db.update('auto', auto.toMap(), where: 'id = ?', whereArgs: [auto.id]);
  }

  Future<void> DeleteAuto(Carro auto) async {
    final db = await _dbHelper.database;
    await db.delete('auto', where: 'id = ?', whereArgs: [auto.id]);
  }

  Future<List<Carro>> selectAuto() async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('auto');

    return List.generate(tipoJSON.length, (i){
      return Carro.fromMap(tipoJSON[i]);
    });
  }


}