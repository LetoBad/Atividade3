class Destino {
  final int? id;
  final String ciudad;
  final double distancia;

  Destino({this.id, required this.ciudad, required this.distancia});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ciudad': ciudad,
      'distancia': distancia,
    };
  }

  static Destino fromMap(Map<String, dynamic> map) {
    return Destino(
      id: map['id'],
      ciudad: map['ciudad'],
      distancia: map['distancia'],
    );
  }
}
