import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Center(
        child: Lottie.asset("assets/loading.json",
            width: 38, height: 38, fit: BoxFit.fill,
            ),
      ),
    );
  }
}
