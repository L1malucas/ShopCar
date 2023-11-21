import 'package:flutter/material.dart';
import 'package:mobile/Models/car_model.dart';
import 'package:mobile/Services/car_request.dart';
import 'package:mobile/Views/Components/car_preview.dart';
import 'package:mobile/Views/Pages/create_edit_car_page.dart';
import 'package:mobile/Views/Pages/login_page.dart';

// ignore: must_be_immutable
class CarListPage extends StatefulWidget {
  CarListPage({
    required this.isTokenValidado,
    Key? key,
  }) : super(key: key);

  // int lenght;
  bool isTokenValidado;

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  List<CarModel> _carrosAll = [];
  List<CarModel> _carrosPrice = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      if (_carrosAll.isEmpty) {
        _carrosAll = await CarRequest.getAllCars();
      }
      if (_carrosPrice.isEmpty) {
        _carrosPrice = await CarRequest.getCarPrice();
      }
      setState(() {});
    } catch (e) {
      debugPrint('Error fetching car details: $e');
    }
  }

  Future<void> _refreshData() async {
    _carrosAll = await CarRequest.getAllCars();
    _carrosPrice = await CarRequest.getCarPrice();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.isTokenValidado,
            child: IconButton(
              tooltip: 'Adicione um novo carro',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEditCar(isEdit: false),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.manage_accounts,
            color: widget.isTokenValidado ? Colors.green : Colors.red,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('\t Vitrine'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 3),
            () {
              setState(() {
                _refreshData();
              });
            },
          );
        },
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: const Text(
                      'Recomendações',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0),
                    height: 200,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _carrosPrice.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return CarPreview(
                          car: _carrosPrice[index],
                          height: 100,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                    width: double.infinity,
                    child: const Text(
                      'Todos Carros Disponíveis',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _carrosAll.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return CarPreview(
                          car: _carrosAll[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
