import 'package:calculadora/Auto.dart';
import 'package:calculadora/Listinha.dart';
import 'package:flutter/material.dart';

class Listinhaautos extends StatefulWidget {
  final List<Carro> carros;
  final Function(int) onRemove;
  final Function(Carro) onInsert;

  const Listinhaautos(
      {required this.carros,
      required this.onRemove,
      required this.onInsert,
      super.key});

  @override
  State<Listinhaautos> createState() => _listCarsState();
}

class _listCarsState extends State<Listinhaautos> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              children: [
                TextField(
                  decoration:
                      const InputDecoration(label: Text("Nome do Carro")),
                  controller: _nomeController,
                ),
                TextField(
                  decoration:
                      const InputDecoration(label: Text("KMs por Litro")),
                  controller: _kmController,
                ),
                ElevatedButton(
                  child: const Text("Salvar"),
                  onPressed: () {
                    final String nome = _nomeController.text;
                    final double? km = double.tryParse(_kmController.text);

                    if (nome.isNotEmpty && km != null) {
                      widget.onInsert(Carro(marca: nome, autonomia: km));

                      _nomeController.clear();
                      _kmController.clear();

                      Navigator.pop(context);

                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content: Text("Carro adicionado com sucesso!")));
                    } else {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Preencha os campos corretamente!")));
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Lista de carros",
            style: TextStyle(
              fontSize: 16,
              color: Colors.lightGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true),
      body: ListView.builder(
        itemCount: widget.carros.length,
        itemBuilder: (context, index) {
          return listinha(
            nome: widget.carros[index].marca,
            km: widget.carros[index].autonomia,
            onRemoved: () => widget.onRemove(index),
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
