class Destino {
  int? id;
  String Ciudad = "";
  double distancia = 0;

  Destino({
    this.id,
    required this.Ciudad, required this.distancia});

Map<String, dynamic> toMap(){
    return {
      'id': id,
      'Ciudad': Ciudad,
      'Distancia': distancia,
    };
  }

  factory Destino.fromMap(Map<String, dynamic> map){
    return Destino(Ciudad: map['Ciudad'], 
    id: map['id'],
    distancia: map['distancia'], 
    );
  }

}
