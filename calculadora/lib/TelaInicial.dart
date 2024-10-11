import 'package:calculadora/Auto.dart';
import 'package:calculadora/Calculadora.dart';
import 'package:calculadora/Destino.dart';
import 'package:calculadora/ListaDeCarros.dart';
import 'package:calculadora/ListaDeDestino.dart';
import 'package:flutter/material.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  int _indexSelecionado = 0;

  final List<Carro> _carros = [
    Carro(marca: "Porsche GT3 RS", autonomia: 11.0),
    Carro(marca: "Audi R8", autonomia: 12.0),
  ];

  final List<Destino> _destinos = [
    Destino(Ciudad: "Durazno", distancia: 300),
    Destino(Ciudad: "Montevideo", distancia: 500)
  ];

  void _itemSelecionado(int index) {
    setState(() {
      _indexSelecionado = index;
    });
  }

  void _delCarro(int index) {
    setState(() {
      _carros.removeAt(index);
    });
  }

  void _insCarro(Carro newCarro) {
    setState(() {
      _carros.add(newCarro);
    });
  }

  void _insDestino(Destino newDestino) {
    setState(() {
      _destinos.add(newDestino);
    });
  }

  void _delDestino(int index) {
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
        onTap: _itemSelecionado,
      ),
    );
  }
}
