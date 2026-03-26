import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../constants/animations.dart';
import '../constants/durations.dart';

class Confetti extends StatefulWidget {
  final Duration waitDuration;

  const Confetti({
    this.waitDuration = Duration.zero,
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  static const animationName = 'Animation 1';

  File? file;
  Artboard? artboard;
  SingleAnimationPainter? painter;
  Timer? startTimer;
  Timer? replayTimer;

  @override
  void initState() {
    super.initState();

    /// Delay the first playback
    startTimer = Timer(
      widget.waitDuration,
      startPlayback,
    );
  }

  Future<void> startPlayback() async {
    if (!mounted) {
      return;
    }

    file ??= await File.asset(
      ModerniAliasAnimations.confetti,
      riveFactory: Factory.rive,
    );

    if (!mounted || file == null) {
      return;
    }

    final nextArtboard = file?.defaultArtboard();

    if (nextArtboard == null) {
      return;
    }

    /// Read the animation duration from the new artboard so the one-shot
    /// playback can restart after the same pause as before.
    ///
    final animation = nextArtboard.animationNamed(animationName);
    final replayDelay = Duration(
      milliseconds: ((animation?.duration ?? 0) * 1000).round() + ModerniAliasDurations.verySlowAnimation.inMilliseconds,
    );

    animation?.dispose();

    final previousArtboard = artboard;
    final previousPainter = painter;

    setState(() {
      artboard = nextArtboard;
      painter = SingleAnimationPainter(
        animationName,
        fit: Fit.cover,
      );
    });

    previousPainter?.dispose();
    previousArtboard?.dispose();

    replayTimer?.cancel();

    replayTimer = Timer(
      replayDelay,
      startPlayback,
    );
  }

  @override
  void dispose() {
    startTimer?.cancel();
    replayTimer?.cancel();
    painter?.dispose();
    artboard?.dispose();
    file?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (artboard == null || painter == null) {
      return const SizedBox.shrink();
    }

    return RiveArtboardWidget(
      artboard: artboard!,
      painter: painter!,
    );
  }
}
