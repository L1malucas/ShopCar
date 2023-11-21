import 'package:flutter/material.dart';
import 'package:mobile/Models/car_model.dart';
import 'package:mobile/Views/Pages/create_edit_car_page.dart';
import 'package:mobile/utils/constants.dart';
import '../../Services/car_request.dart';
import '../Widgets/fixed_spacer_widget.dart';

class CarComponent extends StatefulWidget {
  const CarComponent({required this.carId, super.key});
  final int carId;
  @override
  State<CarComponent> createState() => _CarComponentState();
}

class _CarComponentState extends State<CarComponent> {
  final String texto = "blablablablabla";
  CarModel? _carModel;

  @override
  void initState() {
    super.initState();
    getId();
  }

  Future<void> getId() async {
    try {
      final carroModel = await CarRequest.getCarId(widget.carId);
      setState(() {
        _carModel = carroModel;
      });
    } catch (e) {
      debugPrint('Error fetching carro details: $e');
    }
  }

  Future<void> getPrice() async {
    try {
      final carroModel = await CarRequest.getCarId(widget.carId);
      setState(() {
        _carModel = carroModel;
      });
    } catch (e) {
      debugPrint('Error fetching carro details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: Constants.isLogged,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateEditCar(
                                isEdit: true,
                                currentCarModel: _carModel,
                              )));
                },
                icon: const Icon(Icons.edit)),
          )
        ],
        centerTitle: true,
        title: const Text('Detalhes'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FixedSpacer.vNormal(),
                _carModel?.marca != null
                    ? SizedBox(
                        width: double.infinity,
                        child: Text(
                          _carModel?.marca.toUpperCase() ??
                              'Marca não encontrada.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const CircularProgressIndicator(),
                FixedSpacer.vSmallest(),
                _carModel?.modelo != null
                    ? SizedBox(
                        width: double.infinity,
                        child: Text(
                          _carModel?.modelo.toUpperCase() ??
                              'Marca não encontrada.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 32),
                        ),
                      )
                    : const CircularProgressIndicator(),
                FixedSpacer.vNormal(),
                FixedSpacer.vBiggest(),
                _carModel?.modelo != null
                    ? Image.network(
                        '${_carModel?.foto}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      )
                    : const CircularProgressIndicator(),
                FixedSpacer.vBiggest(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.grey.shade900,
          ),
          width: double.infinity,
          child: _carModel?.marca != null
              ? Text(
                  'Preço R\$ ${_carModel?.preco}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              : const LinearProgressIndicator(),
        ),
      ),
    );
  }
}
