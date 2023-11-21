// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import '../../Models/car_model.dart';
import '../../Services/car_request.dart';
import '../Widgets/alert_widget.dart';
import '../Widgets/fixed_spacer_widget.dart';
import '../Widgets/loading_widget.dart';
import 'car_list_page.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CreateEditCar extends StatefulWidget {
  CreateEditCar({required this.isEdit, this.currentCarModel, super.key});
  bool isEdit = false;
  CarModel? currentCarModel;
  @override
  State<CreateEditCar> createState() => _CreateEditCarState();
}

class _CreateEditCarState extends State<CreateEditCar> {
  final _formKey = GlobalKey<FormState>();
  final _modeloFormController = TextEditingController();
  final _marcaFormController = TextEditingController();
  final _precoFormController = TextEditingController();
  final _fotoFormController = TextEditingController();
  File? imageFile;
  dynamic _currentId;
  @override
  void initState() {
    _populateFormFields();
    debugPrint('no INIT $_currentId');
    super.initState();
  }

  void _populateFormFields() {
    if (widget.currentCarModel != null) {
      _currentId = widget.currentCarModel!.id;
      _modeloFormController.text = widget.currentCarModel!.modelo;
      _marcaFormController.text = widget.currentCarModel!.marca;
      _precoFormController.text = widget.currentCarModel!.preco.toString();
      _fotoFormController.text = widget.currentCarModel!.foto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.isEdit,
            child: IconButton(
                onPressed: () {
                  debugPrint('no button $_currentId');

                  if (_currentId != null) {
                    _deleteCar(_currentId);
                  } else {
                    debugPrint('O ID é nulo. Não é possível excluir.');
                  }
                },
                icon: const Icon(Icons.delete_forever)),
          )
        ],
        title: widget.isEdit
            ? const Text('Editar carro')
            : const Text('Adicionar carro'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FixedSpacer.vBiggest(),
                          TextFormField(
                            controller: _modeloFormController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              hintText: "Digite o modelo",
                              border: const OutlineInputBorder(),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o modelo';
                              }
                              return null;
                            },
                          ),
                          FixedSpacer.vNormal(),
                          TextFormField(
                            controller: _marcaFormController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              hintText: "Digite o marca",
                              border: const OutlineInputBorder(),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o marca';
                              }
                              return null;
                            },
                          ),
                          FixedSpacer.vNormal(),
                          TextFormField(
                            controller: _precoFormController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              hintText: "Digite o preço",
                              border: const OutlineInputBorder(),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o preço';
                              }
                              return null;
                            },
                          ),
                          FixedSpacer.vNormal(),
                           TextFormField(
                            controller: _fotoFormController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              hintText: "Link da foto",
                              border: const OutlineInputBorder(),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira um link';
                              }
                              return null;
                            },
                          ),
                          // AQUI SERIA O ENVIO VIA ARQUIVO, CASO EU CONSEGUISSE UPAR IMAGEM
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     InkWell(
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(2.0),
                          //             color: Colors.blue[100],
                          //             border: Border.all(
                          //                 color: Colors.white, width: 2.0)),
                          //         width: 70,
                          //         height: 70,
                          //         child: Icon(
                          //           Icons.add,
                          //           color: Colors.blue[700],
                          //           size: 24,
                          //         ),
                          //       ),
                          //       onTap: () async {
                          //         await pickImage();
                          //       },
                          //     ),
                          //     imageFile != null
                          //         ? Image.file(
                          //             imageFile!,
                          //             width: 70,
                          //             height: 70,
                          //           )
                          //         : Container(),
                          //   ],
                          // ),
                          FixedSpacer.vNormal(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 60, minWidth: 200),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(24.0),
                              ),
                              child: const Text(
                                'Salvar',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                              onPressed: () {
                                widget.isEdit ? _updateCar() : _createCar();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        )),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
      );

      if (image == null) return;

      final File pickedImage = File(image.path);
      setState(() {
        imageFile = pickedImage;
      });

      return imageFile;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  void _createCar() async {
    if (_formKey.currentState!.validate() && imageFile != null) {
      debugPrint('entrou');

      CarModel newCar = CarModel(
        id: 0,
        modelo: _modeloFormController.text,
        marca: _marcaFormController.text,
        preco: double.parse(_precoFormController.text),
        foto: _fotoFormController.text,
        // foto: imageFile!.path as File,
      );

      try {
        await CarRequest.postCar(adminToken!, newCar);
        LoadingWidget.showProgressDialog(
          context,
          "Carro criado! \n Você será redirecionado para a vitrine",
          CarListPage(isTokenValidado: true),
        );
      } catch (e) {
        Alert(
                context: context,
                title: 'Falha ao criar',
                message: '$e',
                type: AlertType.error)
            .show();
        throw Exception(e);
      }
    }
  }

  void _updateCar() async {
    if (_formKey.currentState!.validate()) {
      debugPrint('entrou');

      CarModel existingCar = await CarRequest.getCarId(_currentId);
      existingCar.modelo = _modeloFormController.text;
      existingCar.marca = _marcaFormController.text;
      existingCar.preco = double.parse(_precoFormController.text);
      existingCar.foto = _fotoFormController.text;

      try {
        await CarRequest.putCar(adminToken!, _currentId, existingCar);
        LoadingWidget.showProgressDialog(
          context,
          "Carro atualizado! \n Você será redirecionado para a vitrine",
          CarListPage(isTokenValidado: true),
        );
      } catch (e) {
        Alert(
                context: context,
                title: 'Falha ao atualizar',
                message: '$e',
                type: AlertType.error)
            .show();
        throw Exception(e);
      }
    }
  }

  void _deleteCar(int carId) async {
    debugPrint('entrou');

    try {
      await CarRequest.deleteCar(adminToken!, carId);
      debugPrint('no metodo $carId');

      LoadingWidget.showProgressDialog(
        context,
        "Carro deletado! \n Você será redirecionado para a vitrine",
        CarListPage(isTokenValidado: true),
      );
    } catch (e) {
      Alert(
              context: context,
              title: 'Falha ao excluir',
              message: '$e',
              type: AlertType.error)
          .show();
      throw Exception(e);
    }
  }
}
