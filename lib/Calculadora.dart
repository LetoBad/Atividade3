import 'package:calculadora/Auto.dart';
import 'package:calculadora/Destino.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  final List<Carro> carros;
  final List<Destino> destinos;

  const Calculadora({
    super.key,
    required this.carros,
    required this.destinos,
  });

  @override
  State<Calculadora> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<Calculadora> {
  String? _carroSelecionado;
  String? _destinoSelecionado;
  double _custoComum = 0;
  double _custopodium = 0;

  double precoGasolinaComum = 5.30;
  double precoPodium = 6.50;

  final TextEditingController _comumController = TextEditingController();
  final TextEditingController _podiumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comumController.text = precoGasolinaComum.toString();
    _podiumController.text = precoPodium.toString();
  }

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
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text("Defina los precios"),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Comum (R\$)"),
                          const SizedBox(width: 35),
                          SizedBox(
                            width: 100,
                            height: 80,
                            child: TextField(
                              style: const TextStyle(fontSize: 35),
                              controller: _comumController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Podium (R\$)"),
                          const SizedBox(width: 35),
                          SizedBox(
                            width: 100,
                            height: 80,
                            child: TextField(
                              style: const TextStyle(fontSize: 35),
                              controller: _podiumController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 150),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            minimumSize: const Size(200, 50),
                          ),
                          onPressed: () {
                            setState(() {
                              precoGasolinaComum =
                                  double.parse(_comumController.text);
                              precoPodium =
                                  double.parse(_podiumController.text);
                            });
                            Navigator.pop(context); // Fechar modal
                          },
                          child: const Text("Confirmar",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void calcularCusto() {
    if (_carroSelecionado != null && _destinoSelecionado != null) {
      Carro carro =
          widget.carros.firstWhere((car) => car.marca == _carroSelecionado);
      Destino destino = widget.destinos
          .firstWhere((dest) => dest.Ciudad == _destinoSelecionado);

      double litrosNecessarios = destino.distancia / carro.autonomia;

      setState(() {
        _custoComum = litrosNecessarios * precoGasolinaComum;
        _custopodium = litrosNecessarios * precoPodium;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: Icon(
                      Icons.opacity,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Comum"),
                      Text(precoGasolinaComum.toString()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Podium"),
                      Text(precoPodium.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Calcular",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                "Selecione um carro e seu destino.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 300,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Selecione um carro"),
                  value: _carroSelecionado,
                  items: widget.carros.map((Carro carro) {
                    return DropdownMenuItem<String>(
                      value: carro.marca,
                      child: Text(carro.marca),
                    );
                  }).toList(),
                  onChanged: (String? novoCarro) {
                    setState(() {
                      _carroSelecionado = novoCarro;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 300,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Selecione um destino"),
                  value: _destinoSelecionado,
                  items: widget.destinos.map((Destino destino) {
                    return DropdownMenuItem<String>(
                      value: destino.Ciudad,
                      child: Text(destino.Ciudad),
                    );
                  }).toList(),
                  onChanged: (String? novoDestino) {
                    setState(() {
                      _destinoSelecionado = novoDestino;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Custo Total:",
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Gasolina Comum:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "BRL${_custoComum.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Gasolina Podium:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "BRL${_custopodium.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),
              backgroundColor: Colors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              calcularCusto();
            },
            child: const Text(
              "Calcular",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50, left: 0),
            width: 140,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: const BorderSide(color: Colors.lightGreen, width: 1.0),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                openModal(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.lightGreen,
                    size: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Alterar preço",
                    style: TextStyle(fontSize: 12, color: Colors.lightGreen),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
