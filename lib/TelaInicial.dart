import 'package:calculadora/Auto.dart';
import 'package:calculadora/Destino.dart';
import 'package:calculadora/ListaDeCarros.dart';
import 'package:calculadora/ListaDeDestino.dart';
import 'package:calculadora/Calculadora.dart';
import 'package:calculadora/CarroDao.dart';
import 'package:calculadora/DestinoDao.dart';
import 'package:flutter/material.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  int _indexSelecionado = 0;

  final CarroDao _carroDao = CarroDao();
  final DestinoDao _destinoDao = DestinoDao();
  List<Carro> _carros = [];
  List<Destino> _destinos = [];

  @override
  void initState() {
    super.initState();
    _loadData(); // Cargar datos de la base de datos
  }

  void _loadData() async {
    _carros = await _carroDao.selectCarros(); // Recuperar carros
    _destinos = await _destinoDao.selectDestinos(); // Recuperar destinos
    setState(() {});
  }

  void _delCarro(int index) async {
    await _carroDao.deleteCarro(_carros[index]); // Eliminar de la base de datos
    setState(() {
      _carros.removeAt(index);
    });
  }

  void _insCarro(Carro newCarro) async {
    await _carroDao.insertCarro(newCarro); // Insertar en la base de datos
    setState(() {
      _carros.add(newCarro);
    });
  }

  void _insDestino(Destino newDestino) async {
    await _destinoDao.insertDestino(newDestino); // Insertar en la base de datos
    setState(() {
      _destinos.add(newDestino);
    });
  }

  void _delDestino(int index) async {
    await _destinoDao
        .deleteDestino(_destinos[index]); // Eliminar de la base de datos
    setState(() {
      _destinos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Calculadora(
        carros: _carros,
        destinos: _destinos,
      ),
      Listadecarros(
        carros: _carros,
        onRemove: _delCarro,
        onInsert: _insCarro,
      ),
      Listadedestino(
        destinos: _destinos,
        onInsert: _insDestino,
        onRemove: _delDestino,
      ),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions[_indexSelecionado],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cálculo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Carros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Destinos',
          ),
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.lightGreen,
        onTap: (index) {
          setState(() {
            _indexSelecionado = index;
          });
        },
      ),
    );
  }
}
