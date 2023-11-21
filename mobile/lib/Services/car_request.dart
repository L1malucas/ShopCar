import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/car_model.dart';
import '../utils/constants.dart';

String? adminToken = Constants.adminToken.toString();

class CarRequest {
  static const baseUrl = '${Constants.apiAzure}/carros';

  static Future<CarModel> getCarId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final carModel = CarModel.fromJson(jsonData);
      return carModel;
    } else {
      throw Exception('Falha na request GetId');
    }
  }

  static Future<List<CarModel>> getCarPrice() async {
    final response = await http.get(Uri.parse('$baseUrl/preco'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => CarModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha na request GetAll');
    }
  }

  static Future<List<CarModel>> getAllCars() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => CarModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha na request GetAll');
    }
  }

  static Future<CarModel> postCar(String token, CarModel carro) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(carro.toJson()),
    );

    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);

      return CarModel.fromJson(jsonData);
    } else {
      throw Exception('Falha na request PostCar');
    }
  }

  static Future<void> putCar(String token, int id, CarModel carro) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(carro.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha na request PutCar');
    }
  }

  static Future<void> deleteCar(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Falha na request DeleteCar');
    } else if (token.isEmpty) {
      throw Exception('Falha no token');
    }
  }
}
