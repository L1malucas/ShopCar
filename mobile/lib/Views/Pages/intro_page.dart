import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../Widgets/fixed_spacer_widget.dart';
import '../Widgets/loading_widget.dart';
import 'car_list_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400.withOpacity(0.5),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CarVerzel',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              FixedSpacer.vBiggest(),
              SvgPicture.asset('assets/images/logo_verzel.svg',
                  height: 150,
                  width: double.infinity,
                  semanticsLabel: 'Verzel Logo'),
              FixedSpacer.vBigger(),
              const Text(
                'Vitrine de Carros',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              FixedSpacer.vBigger(),
              const Text(
                'Teste técnico, feito por Lucas Lima',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              FixedSpacer.vSmaller(),
              InkWell(
                child: Text(
                  style: TextStyle(color: Colors.blue.shade100, fontSize: 20),
                  'Repositório Github',
                ),
                onTap: () {
                  launchUrl(Constants.urlGithubRepo,
                      mode: LaunchMode.externalApplication);
                },
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 60),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(24.0),
            ),
            child: const Text(
              'Vamos Começar!',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              LoadingWidget.showProgressDialog(
                  context,
                  'Carregando a vitrine',
                  CarListPage(
                    isTokenValidado: false,
                  ));
            },
          ),
        ),
      ),
    );
  }
}
