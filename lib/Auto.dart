class Carro {
  int? id;
  String marca = "";
  double autonomia = 0;

  Carro({
  this.id,  
  required this.marca, 
  required this.autonomia});

Map<String, dynamic> toMap(){
    return {
      'id': id,
      'marca': marca,
      'autonomia': autonomia,
    };
  }

  factory Carro.fromMap(Map<String, dynamic> map){
    return Carro(marca: map['marca'], 
    id: map['id'],
    autonomia: map['autonomia'], 
    );
  }


}
