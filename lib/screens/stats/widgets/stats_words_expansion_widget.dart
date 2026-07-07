import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/durations.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../models/round/round.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
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

  var waveformData = <double>[];

  PlayerController? audioController;
  StreamSubscription<PlayerState>? playerStateSubscription;
  StreamSubscription<dynamic>? audioCompletionSubscription;
  late final AnimationController animationController;

  /// Icon toggle animation (play / pause)
  void initializeAnimations() => animationController = AnimationController(
    duration: ModerniAliasDurations.animation,
    vsync: this,
  );

  /// If there's an `audioRecording`, initialize `audioController` and show the [Waveform] widget
  Future<void> initializeAudio() async {
    final audioRecording = widget.round.audioRecording;

    if (audioRecording != null) {
      final controller = PlayerController()..updateFrequency = UpdateFrequency.high;

      audioController = controller;
      var audioPrepared = false;
      var controllerReleased = false;
      audioInitializationRunning = true;

      try {
        await controller.preparePlayer(
          path: audioRecording,
          shouldExtractWaveform: false,
        );

        await controller.setFinishMode(
          finishMode: FinishMode.pause,
        );
        audioPrepared = true;

        if (!mounted || disposeRequested) {
          return;
        }
        setState(() {});

        playerStateSubscription = controller.onPlayerStateChanged.listen(audioControllerListener);
        audioCompletionSubscription = controller.onCompletion.listen(audioCompletionListener);

        final extractedWaveformData = await controller.waveformExtraction.extractWaveformData(
          path: audioRecording,
          noOfSamples: 140,
        );

        if (!mounted || disposeRequested) {
          return;
        }

        waveformData = extractedWaveformData;

        if (waveformData.isEmpty) {
          getIt.get<LoggerService>().w('No waveform data extracted from $audioRecording');
        }

        if (mounted && !disposeRequested) {
          setState(() {});
        }
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

  Future<void> safelyReleaseAudioController(PlayerController controller) async {
    try {
      if (controller.playerState != PlayerState.stopped) {
        await controller.stopPlayer();
      }
      await controller.release();
    } catch (_) {}
  }

  /// Triggered whenever [PlayerState] in `audioController` changes
  void audioControllerListener(PlayerState event) {
    /// Show play icon
    if (event.isInitialised || event.isPaused || event.isStopped) {
      animateBackward();
    }

    /// Show pause icon
    if (event.isPlaying) {
      audioFinished = false;
      animateForward();
    }
  }

  /// Triggered when the audio reaches the end
  void audioCompletionListener(_) => audioFinished = true;

  /// Play / pause current `audioController`
  Future<void> toggleAudio() async {
    try {
      switch (audioController?.playerState) {
        case PlayerState.initialized:
          await audioController?.startPlayer();
          break;
        case PlayerState.paused:
          if (audioFinished) {
            await audioController?.seekTo(0);
            audioFinished = false;
          }
          await audioController?.startPlayer();
          break;
        case PlayerState.playing:
          await audioController?.pausePlayer();
          break;
        case PlayerState.stopped:
          await audioController?.startPlayer();
          break;

        default:
          await audioController?.startPlayer();
      }
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
    audioCompletionSubscription?.cancel();

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (waveformData.isEmpty) {
                    return const SizedBox(height: 48);
                  }

                  return AudioFileWaveforms(
                    playerController: audioController!,
                    size: Size(constraints.maxWidth, 48),
                    waveformData: waveformData,
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor: ModerniAliasColors.white.withValues(alpha: 0.05),
                      liveWaveColor: ModerniAliasColors.white,
                      scaleFactor: 144,
                      showSeekLine: false,
                    ),
                  );
                },
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
