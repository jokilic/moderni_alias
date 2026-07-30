import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../constants/colors.dart';

class RecordingWaveform extends StatefulWidget {
  final AudioRecorder recorder;
  final EdgeInsets padding;

  const RecordingWaveform({
    required this.recorder,
    required this.padding,
  });

  @override
  State<RecordingWaveform> createState() => RecordingWaveformState();
}

class RecordingWaveformState extends State<RecordingWaveform> {
  final amplitudes = <double>[];
  StreamSubscription<Amplitude>? amplitudeSubscription;
  StreamSubscription<RecordState>? recordStateSubscription;

  @override
  void initState() {
    super.initState();

    amplitudeSubscription = widget.recorder.onAmplitudeChanged(const Duration(milliseconds: 80)).listen(addAmplitude);
    recordStateSubscription = widget.recorder.onStateChanged().listen(recordStateChanged);
  }

  void recordStateChanged(RecordState state) {
    if (state == RecordState.record && mounted) {
      setState(amplitudes.clear);
    }
  }

  void addAmplitude(Amplitude amplitude) {
    if (!mounted) {
      return;
    }

    /// `record` reports dBFS values
    /// Normalize the useful microphone range
    final normalizedAmplitude = ((amplitude.current + 60) / 60).clamp(0.04, 1.0);

    setState(() {
      amplitudes.add(normalizedAmplitude);

      if (amplitudes.length > 140) {
        amplitudes.removeAt(0);
      }
    });
  }

  @override
  void dispose() {
    amplitudeSubscription?.cancel();
    recordStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: widget.padding,
    child: SizedBox(
      height: 48,
      width: double.infinity,
      child: CustomPaint(
        painter: RecordingWaveformPainter(
          amplitudes: amplitudes,
        ),
      ),
    ),
  );
}

class RecordingWaveformPainter extends CustomPainter {
  final List<double> amplitudes;

  RecordingWaveformPainter({
    required this.amplitudes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ModerniAliasColors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    const spacing = 4.0;
    final numberOfBars = max(1, (size.width / spacing).floor());
    final visibleAmplitudes = amplitudes.length > numberOfBars ? amplitudes.sublist(amplitudes.length - numberOfBars) : amplitudes;
    final leadingEmptyBars = numberOfBars - visibleAmplitudes.length;

    for (var index = 0; index < numberOfBars; index++) {
      final amplitudeIndex = index - leadingEmptyBars;
      final amplitude = amplitudeIndex >= 0 ? visibleAmplitudes[amplitudeIndex] : 0.04;
      final barHeight = max(2, amplitude * size.height);
      final x = index * spacing + paint.strokeWidth / 2;

      canvas.drawLine(
        Offset(x, (size.height - barHeight) / 2),
        Offset(x, (size.height + barHeight) / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(RecordingWaveformPainter oldDelegate) => true;
}
