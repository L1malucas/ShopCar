import 'package:flutter/material.dart';

enum AlertType {
  success(title: "Sucesso!", confirmButton: "Fechar"),
  warning(title: "Atenção!", confirmButton: "Fechar"),
  error(title: "Ops...", confirmButton: "Fechar"),
  yesNo(confirmButton: "Sim", cancelButton: "Não");

  const AlertType({this.title, required this.confirmButton, this.cancelButton});
  final String? title;
  final String confirmButton;
  final String? cancelButton;
}

class Alert {
  const Alert({
    required this.context,
    required this.type,
    this.title,
    required this.message,
    this.onConfirmPressed,
    this.onCancelPressed,
  }) : super();

  final BuildContext context;
  final String? title;
  final String message;
  final Function()? onConfirmPressed;
  final Function()? onCancelPressed;
  final AlertType type;

  static const double _defaultMargin = 16;

  show() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: (title != null
            ? Text(title!)
            : (type.title != null ? Text(type.title!) : null)),
        content: Text(message),
        actions: <Widget>[
          _buildButton(
              name: type.confirmButton,
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirmPressed != null) {
                  onConfirmPressed!();
                }
              }),
          _buildButton(
              name: type.cancelButton,
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancelPressed != null) {
                  onCancelPressed!();
                }
              })
        ],
      ),
    );
  }

  Widget _buildButton({String? name, required Function() onPressed}) {
    return name != null
        ? TextButton(
            onPressed: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: _defaultMargin),
              child: Text(name),
            ),
          )
        : const Text("");
  }
}
