import 'dart:async';

import 'package:flip_clock_example/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FlipClockPage extends StatefulWidget {
  const FlipClockPage({super.key});

  @override
  State<FlipClockPage> createState() => _FlipClockPageState();
}

class _FlipClockPageState extends State<FlipClockPage> {
  final _timerController = StreamController<DateTime>();
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    //Adding new value each second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timerController.sink.add(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timerController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4CC8C8),
            Color(0xFF202033),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Flip clock example',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: StreamBuilder<DateTime>(
            stream: _timerController.stream,
            builder: (context, snapshot) {
              final currentTime = snapshot.data ?? DateTime.now();

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlipNumberWidget(
                      number: currentTime.hour,
                    ),
                    const SizedBox(height: 10),
                    FlipNumberWidget(
                      number: currentTime.minute,
                    ),
                    const SizedBox(height: 10),
                    FlipNumberWidget(
                      number: currentTime.second,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
