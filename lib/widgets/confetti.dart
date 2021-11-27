import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Confetti extends StatefulWidget {
  @override
  _ConfettiState createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  late final ConfettiController confettiController;

  @override
  void initState() {
    super.initState();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    confettiController.play();
  }

  @override
  void dispose() {
    super.dispose();

    confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) => ConfettiWidget(
        confettiController: confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: true,
      );
}
