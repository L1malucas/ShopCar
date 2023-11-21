import 'package:flutter/material.dart';

class LoadingWidget {
  static Future<void> showProgressDialog(
      BuildContext context, String message, Widget destinationRoute,
      [bool mounted = true]) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destinationRoute),
    );
  }
}
