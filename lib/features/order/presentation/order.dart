import 'package:flutter/material.dart';

class SpinningDonutScreen extends StatefulWidget {
  const SpinningDonutScreen({super.key});

  @override
  State<SpinningDonutScreen> createState() => _SpinningDonutScreenState();
}

class _SpinningDonutScreenState extends State<SpinningDonutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // تدوير مستمر
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset(
            'assets/images/donut.png', // تأكد من المسار الصحيح
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
