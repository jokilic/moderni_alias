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

  PlayerController? audioController;
  late final AnimationController animationController;

  Future<void> initializeAnimations() async {
    /// Icon toggle animation (play / pause)
    animationController = AnimationController(
      duration: ModerniAliasDurations.animation,
      vsync: this,
    );
  }

  /// If there's an `audioRecording`, initialize `audioController` and show the Waveform widget
  Future<void> initializeAudio() async {
    if (widget.round.audioRecording != null) {
      audioController = PlayerController();
      await audioController?.preparePlayer(path: widget.round.audioRecording!);
      audioController?.onPlayerStateChanged.listen(audioControllerListener);
    }
  }

  /// Triggered whenever [PlayerState] in `audioController` changes
  void audioControllerListener(PlayerState event) {
    /// Show play icon
    if (event.isInitialised || event.isPaused || event.isStopped) {
      animateBackward();
    }

    /// Show pause icon
    if (event.isPlaying) {
      animateForward();
    }
  }

  /// Play / pause current `audioController`
  Future<void> toggleAudio() async {
    try {
      switch (audioController?.playerState) {
        case PlayerState.initialized:
          await audioController?.startPlayer();
          break;
        case PlayerState.paused:
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
      getIt.get<LoggerService>().e('$e');
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
  Future<void> initAnimationsAndAudio() async {
    await initializeAnimations();
    await initializeAudio();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initAnimationsAndAudio();
  }

  @override
  void dispose() {
    animationController.dispose();
    audioController?.dispose();
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
              child: AudioFileWaveforms(
                playerController: audioController!,
                size: Size(MediaQuery.sizeOf(context).width, 48),
                continuousWaveform: false,
                playerWaveStyle: const PlayerWaveStyle(
                  fixedWaveColor: ModerniAliasColors.white,
                  liveWaveColor: ModerniAliasColors.white,
                  scaleFactor: 144,
                  showSeekLine: false,
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
