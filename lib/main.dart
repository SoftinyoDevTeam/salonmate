import 'package:flutter/material.dart';

void main() {
  runApp(const Salonmate());
}

class Salonmate extends StatelessWidget {
  const Salonmate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SALONMATE',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Container());
  }
}
