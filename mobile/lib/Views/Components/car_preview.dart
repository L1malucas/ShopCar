import 'package:flutter/material.dart';
import '../../Models/car_model.dart';
import '../Widgets/fixed_spacer_widget.dart';
import 'car_component.dart';

// ignore: must_be_immutable
class CarPreview extends StatelessWidget {
  CarPreview({
    this.height,
    required this.car,
    Key? key,
  }) : super(key: key);

  double? height;
  CarModel car;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        car.foto,
                        fit: BoxFit.cover,
                        height: height,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/car_not_found.png',
                            fit: BoxFit.cover,
                            height: height,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FixedSpacer.vNormal(),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: Text('${car.marca}  ${car.modelo}',
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  'R\$${car.preco}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarComponent(carId: car.id),
          ),
        );
      },
    );
  }
}
