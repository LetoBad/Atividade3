import 'package:calculadora/Destino.dart';
import 'package:calculadora/ListinhaDestino.dart';
import 'package:flutter/material.dart';
import 'package:calculadora/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class Listadedestino extends StatefulWidget {
  const Listadedestino(
      {super.key,
      required List<Destino> destinos,
      required void Function(Destino newDestino) onInsert,
      required void Function(int index) onRemove});

  @override
  State<Listadedestino> createState() => _listDestinyState();
}

class _listDestinyState extends State<Listadedestino> {
  final TextEditingController _nomeCidadeControl = TextEditingController();
  final TextEditingController _kmCidadeControl = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Destino> _destinos = [];

  @override
  void initState() {
    super.initState();
    _loadDestinos();
  }

  Future<void> _loadDestinos() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('destino');

    setState(() {
      _destinos = List.generate(maps.length, (i) {
        return Destino.fromMap(maps[i]);
      });
    });
  }

  Future<void> _insertDestino(Destino destino) async {
    final db = await _dbHelper.database;
    await db.insert(
      'destino',
      destino.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _loadDestinos();
  }

  Future<void> _deleteDestino(int index) async {
    final db = await _dbHelper.database;
    await db.delete(
      'destino',
      where: 'id = ?',
      whereArgs: [_destinos[index].id],
    );
    _loadDestinos();
  }

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Column(
            children: [
              TextField(
                decoration:
                    const InputDecoration(label: Text("Nome da cidade")),
                controller: _nomeCidadeControl,
              ),
              TextField(
                decoration:
                    const InputDecoration(label: Text("Distância (KM)")),
                controller: _kmCidadeControl,
              ),
              ElevatedButton(
                child: const Text("Salvar"),
                onPressed: () {
                  final String nomeCidade = _nomeCidadeControl.text;
                  final double? km = double.tryParse(_kmCidadeControl.text);

                  if (nomeCidade.isNotEmpty && km != null) {
                    _insertDestino(Destino(ciudad: nomeCidade, distancia: km));

                    _nomeCidadeControl.clear();
                    _kmCidadeControl.clear();

                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(
                        content: Text("Preencha os campos corretamente!"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lista de Destinos",
          style: TextStyle(
            fontSize: 16,
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _destinos.length,
        itemBuilder: (context, index) {
          return Listinhadestino(
            Ciudad: _destinos[index].ciudad,
            distancia: _destinos[index].distancia,
            onRemoved: () => _deleteDestino(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal(context);
        },
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
