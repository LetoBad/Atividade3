class Carro {
  final int? id;
  final String marca;
  final double autonomia;

  Carro({this.id, required this.marca, required this.autonomia});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marca': marca,
      'autonomia': autonomia,
    };
  }

  static Carro fromMap(Map<String, dynamic> map) {
    return Carro(
      id: map['id'],
      marca: map['marca'],
      autonomia: map['autonomia'],
    );
  }
}
