
import 'package:calculadora/Destino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:calculadora/DatabaseHelper.dart';

class Carrodao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertDestino(Destino destino) async{
    final db = await _dbHelper.database;
    await db.insert('destino', destino.toMap());
    conflictAlgorithm: ConflictAlgorithm.replace;
  }

  Future<void> updateDestino(Destino destino) async {
    final db = await _dbHelper.database;
    await db.update('adestino', destino.toMap(), where: 'id = ?', whereArgs: [destino.id]);
  }

  Future<void> DeleteDestino(Destino destino) async {
    final db = await _dbHelper.database;
    await db.delete('destino', where: 'id = ?', whereArgs: [destino.id]);
  }

  Future<List<Destino>> selectAuto() async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('destino');

    return List.generate(tipoJSON.length, (i){
      return Destino.fromMap(tipoJSON[i]);
    });
  }


}