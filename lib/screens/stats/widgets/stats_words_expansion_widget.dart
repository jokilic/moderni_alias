import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:siri_wave/siri_wave.dart';

import '../../../constants/colors.dart';
import '../../../constants/durations.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../models/round/round.dart';
import '../../../util/snackbars.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../../widgets/scores/played_word_value.dart';

class StatsWordsExpansionWidget extends StatefulWidget {
  final int index;
  final Round round;
  final String someWords;
  final bool quickGameStats;
  final Function() onSharePressed;

  const StatsWordsExpansionWidget({
    required this.index,
    required this.round,
    required this.someWords,
    required this.onSharePressed,
    this.quickGameStats = false,
  });

  @override
  State<StatsWordsExpansionWidget> createState() => _StatsWordsExpansionWidgetState();
}

class _StatsWordsExpansionWidgetState extends State<StatsWordsExpansionWidget> with SingleTickerProviderStateMixin {
  var showSubtitle = true;
  var turns = 0.25;
  var isPlaying = false;
  var audioFinished = false;
  var audioInitializationRunning = false;
  var disposeRequested = false;

  var audioDuration = Duration.zero;
  var audioPosition = Duration.zero;

  AudioPlayer? audioController;

  StreamSubscription<PlayerState>? playerStateSubscription;
  StreamSubscription<Duration>? audioPositionSubscription;

  late final AnimationController animationController;
  late IOS7SiriWaveformController playbackWaveformController;

  /// Icon toggle animation (play / pause)
  void initializeAnimations() => animationController = AnimationController(
    duration: ModerniAliasDurations.animation,
    vsync: this,
  );

  void initializePlaybackWaveform() => playbackWaveformController = IOS7SiriWaveformController(
    amplitude: 0.04,
    color: ModerniAliasColors.white,
    frequency: 4,
    speed: 0.05,
  );

  /// If there's an `audioRecording`, initialize `audioController` and show the playback controls
  Future<void> initializeAudio() async {
    final audioRecording = widget.round.audioRecording;

    if (audioRecording != null) {
      final controller = AudioPlayer();

      audioController = controller;
      var audioPrepared = false;
      var controllerReleased = false;
      audioInitializationRunning = true;

      try {
        audioDuration = await controller.setFilePath(audioRecording) ?? Duration.zero;
        audioPrepared = true;

        if (!mounted || disposeRequested) {
          return;
        }
        setState(() {});

        playerStateSubscription = controller.playerStateStream.listen(audioControllerListener);
        audioPositionSubscription = controller.positionStream.listen(audioPositionListener);
      } catch (e) {
        if (!audioPrepared) {
          await safelyReleaseAudioController(controller);
          controllerReleased = true;
          audioController = null;
        }

        if (mounted && !disposeRequested) {
          setState(() {});
        }
      } finally {
        audioInitializationRunning = false;

        if (disposeRequested && !controllerReleased) {
          await safelyReleaseAudioController(controller);
        }
      }
    }
  }

  Future<void> safelyReleaseAudioController(AudioPlayer controller) async {
    try {
      await controller.stop();
      await controller.dispose();
    } catch (_) {}
  }

  /// Triggered whenever [PlayerState] in `audioController` changes
  void audioControllerListener(PlayerState event) {
    final waveformPlaying = event.playing && event.processingState != ProcessingState.completed;

    /// A new controller makes `siri_wave` rebuild with the updated playback values.
    playbackWaveformController = IOS7SiriWaveformController(
      amplitude: waveformPlaying ? 0.65 : 0.04,
      color: ModerniAliasColors.white,
      frequency: 4,
      speed: waveformPlaying ? 0.2 : 0.05,
    );

    /// Show play icon
    if (!event.playing) {
      animateBackward();
    }

    /// Show pause icon
    if (event.playing) {
      audioFinished = false;
      animateForward();
    }

    if (event.processingState == ProcessingState.completed) {
      audioFinished = true;
      animateBackward();
    }

    if (mounted && !disposeRequested) {
      setState(() {});
    }
  }

  void audioPositionListener(Duration position) {
    if (mounted && !disposeRequested) {
      setState(
        () => audioPosition = position,
      );
    }
  }

  /// Play / pause current `audioController`
  Future<void> toggleAudio() async {
    try {
      final controller = audioController;

      if (controller == null) {
        return;
      }

      if (controller.playing) {
        await controller.pause();
        return;
      }

      if (audioFinished) {
        await controller.seek(Duration.zero);
        audioFinished = false;
      }

      await controller.play();
    } catch (e) {
      showSnackbar(
        context,
        icon: ModerniAliasIcons.wrong,
        text: '$e',
      );
    }
  }

  /// Animates the play / pause icon forward
  void animateForward() {
    if (mounted) {
      animationController.forward();
      isPlaying = true;
    }
  }

  /// Animates the play / pause icon backward
  void animateBackward() {
    if (mounted) {
      animationController.reverse();
      isPlaying = false;
    }
  }

  /// Initializes animations and audio
  void initAnimationsAndAudio() {
    initializeAnimations();
    initializePlaybackWaveform();
    initializeAudio();
  }

  @override
  void initState() {
    super.initState();
    initAnimationsAndAudio();
  }

  @override
  void dispose() {
    disposeRequested = true;
    animationController.dispose();
    playerStateSubscription?.cancel();
    audioPositionSubscription?.cancel();

    final controller = audioController;
    audioController = null;

    if (controller != null && !audioInitializationRunning) {
      safelyReleaseAudioController(controller);
    }

    super.dispose();
  }

  /// Widgets which are shown when opening expansion tile
  List<Widget> buildExpansionTileChildren() => [
    ///
    /// WORDS
    ///
    ...List.generate(
      widget.round.playedWords.length,
      (index) {
        final playedWord = widget.round.playedWords[index];

        return PlayedWordValue(
          word: playedWord.word,
          chosenAnswer: playedWord.chosenAnswer,
        );
      },
    ),

    ///
    /// AUDIO RECORDING
    ///
    if (audioController != null) ...[
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Row(
          children: [
            const SizedBox(width: 20),
            AnimatedGestureDetector(
              onTap: widget.onSharePressed,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: Image.asset(
                  ModerniAliasIcons.share,
                  color: ModerniAliasColors.white,
                  height: 26,
                  width: 26,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 48,
                child: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRect(
                        child: SiriWaveform.ios7(
                          controller: playbackWaveformController,
                          options: IOS7SiriWaveformOptions(
                            height: 48,
                            width: constraints.maxWidth,
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.transparent,
                          inactiveTrackColor: Colors.transparent,
                          thumbColor: ModerniAliasColors.white,
                          overlayColor: ModerniAliasColors.white.withValues(alpha: 0.12),
                          trackHeight: 2,
                        ),
                        child: Slider(
                          padding: EdgeInsets.zero,
                          max: audioDuration.inMilliseconds > 0 ? audioDuration.inMilliseconds.toDouble() : 1,
                          value: audioPosition.inMilliseconds.clamp(0, audioDuration.inMilliseconds).toDouble(),
                          onChanged: audioDuration.inMilliseconds > 0
                              ? (value) => audioController?.seek(
                                  Duration(milliseconds: value.round()),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            AnimatedGestureDetector(
              onTap: toggleAudio,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: animationController,
                  color: ModerniAliasColors.white,
                  size: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    ///
    /// JUST THE WORDS
    ///
    if (widget.quickGameStats) {
      return Column(
        children: buildExpansionTileChildren(),
      );
    }

    ///
    /// EXPANSION TILE
    ///
    return ExpansionTile(
      onExpansionChanged: (value) => setState(() {
        showSubtitle = !value;
        turns = value ? 0.75 : 0.25;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tilePadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      childrenPadding: const EdgeInsets.only(top: 8, bottom: 16),
      leading: Container(
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(
          minHeight: 36,
          minWidth: 36,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ModerniAliasColors.white,
        ),
        child: Text(
          '${widget.index + 1}',
          style: ModerniAliasTextStyles.statsNumber.copyWith(
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: showSubtitle
          ? Text(
              '${widget.someWords}...',
              style: ModerniAliasTextStyles.stats.copyWith(
                fontSize: 16,
              ),
            )
          : null,
      title: Text(
        '${widget.round.playingTeam?.name}',
        style: ModerniAliasTextStyles.stats.copyWith(
          fontSize: 24,
        ),
      ),
      trailing: AnimatedRotation(
        turns: turns,
        duration: ModerniAliasDurations.fastAnimation,
        curve: Curves.easeIn,
        child: Image.asset(
          ModerniAliasIcons.arrowStats,
          color: ModerniAliasColors.white,
          height: 26,
          width: 26,
        ),
      ),
      children: buildExpansionTileChildren(),
    );
  }
}
