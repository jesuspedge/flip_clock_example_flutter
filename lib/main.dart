import 'package:flip_clock_example/view/flip_clock_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flip Clock Example',
      home: FlipClockPage(),
    );
  }
}
