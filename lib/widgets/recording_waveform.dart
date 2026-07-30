import 'dart:async';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:siri_wave/siri_wave.dart';

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
  final waveformController = IOS7SiriWaveformController(
    amplitude: 0.04,
    color: ModerniAliasColors.white,
    frequency: 4,
    speed: 0.15,
  );

  StreamSubscription<Amplitude>? amplitudeSubscription;
  StreamSubscription<RecordState>? recordStateSubscription;

  @override
  void initState() {
    super.initState();

    amplitudeSubscription = widget.recorder.onAmplitudeChanged(const Duration(milliseconds: 80)).listen(addAmplitude);
    recordStateSubscription = widget.recorder.onStateChanged().listen(recordStateChanged);
  }

  void recordStateChanged(RecordState state) {
    if (mounted) {
      setState(() {
        waveformController.amplitude = state == RecordState.record ? 0.04 : 0;
      });
    }
  }

  void addAmplitude(Amplitude amplitude) {
    if (!mounted) {
      return;
    }

    /// `record` reports dBFS values, so normalize the useful microphone range
    final normalizedAmplitude = ((amplitude.current + 60) / 60).clamp(0.04, 1.0);

    setState(
      () => waveformController.amplitude = normalizedAmplitude,
    );
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
    child: LayoutBuilder(
      builder: (context, constraints) => ClipRect(
        child: SiriWaveform.ios7(
          controller: waveformController,
          options: IOS7SiriWaveformOptions(
            height: 48,
            width: constraints.maxWidth,
          ),
        ),
      ),
    ),
  );
}
