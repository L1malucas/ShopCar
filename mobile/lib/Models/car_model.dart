class CarModel {
  int id;
  String modelo;
  String marca;
  double preco;
  String foto;

  CarModel({
    required this.id,
    required this.modelo,
    required this.marca,
    required this.preco,
    required this.foto,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['carId'],
      modelo: json['modelo'],
      marca: json['marca'],
      preco: json['preco'].toDouble(),
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': id,
      'modelo': modelo,
      'marca': marca,
      'preco': preco,
      'foto': foto,
    };
  }
}
