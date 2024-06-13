import 'package:flutter/material.dart';

class NoteLogo extends StatelessWidget {
  const NoteLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logo/notes.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
