import 'package:flutter/material.dart';

class NumberContainer extends StatelessWidget {
  const NumberContainer({
    required this.number,
    super.key,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF191C1D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xACE7E7E7)),
      ),
      child: Text(
        number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 150,
          height: 1,
        ),
      ),
    );
  }
}
