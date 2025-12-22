import 'dart:async';
import 'dart:math' as math;

import 'package:flip_clock_example/widgets/number_container.dart';
import 'package:flutter/material.dart';

class FlipNumberWidget extends StatefulWidget {
  const FlipNumberWidget({required this.number, super.key});

  final int number;

  @override
  State<FlipNumberWidget> createState() => _FlipNumberWidgetState();
}

class _FlipNumberWidgetState extends State<FlipNumberWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationTopHalfController;
  late AnimationController _animationBottomHalfController;

  late Animation<double> _animationTopHalf;
  late Animation<double> _animationBottomHalf;

  late int _numberWhenAnimationEnds;

  bool _animationEnds = true;

  @override
  void initState() {
    super.initState();

    _animationTopHalfController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() => setState(() => {}));
    _animationBottomHalfController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() => setState(() => {}));

    _animationTopHalf =
        Tween<double>(begin: -(math.pi * 2), end: -(math.pi * 1.5))
            .animate(_animationTopHalfController);
    _animationBottomHalf = Tween<double>(begin: -(math.pi * 1.5), end: -math.pi)
        .animate(_animationBottomHalfController);

    _numberWhenAnimationEnds = widget.number;
  }

  Future<void> initAnimation() async {
    setState(() => _animationEnds = false);

    unawaited(_animationTopHalfController.forward());

    if (_animationTopHalfController.isCompleted) {
      unawaited(_animationBottomHalfController.forward());
    }

    if (_animationTopHalfController.isCompleted &&
        _animationBottomHalfController.isCompleted) {
      setState(() => _numberWhenAnimationEnds = widget.number);
      setState(() => _animationEnds = true);
      _animationTopHalfController.reset();
      _animationBottomHalfController.reset();
    }
  }

  @override
  void dispose() {
    _animationTopHalfController.dispose();
    _animationBottomHalfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentNumber =
        widget.number < 10 ? '0${widget.number}' : widget.number.toString();
    final previusNumber = _numberWhenAnimationEnds < 10
        ? '0$_numberWhenAnimationEnds'
        : _numberWhenAnimationEnds.toString();

    if (_numberWhenAnimationEnds != widget.number) unawaited(initAnimation());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.5,
                child: NumberContainer(number: currentNumber),
              ),
              Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.5,
                child: AnimatedBuilder(
                  animation: _animationTopHalf,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_animationTopHalf.value),
                      child: child,
                    );
                  },
                  child: NumberContainer(
                    number: _animationEnds ? currentNumber : previusNumber,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        ClipRect(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.5,
                child: NumberContainer(
                  number: _animationEnds ? currentNumber : previusNumber,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.5,
                child: AnimatedBuilder(
                  animation: _animationBottomHalf,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_animationBottomHalf.value),
                      child: child,
                    );
                  },
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationX(math.pi),
                    child: NumberContainer(number: currentNumber),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
