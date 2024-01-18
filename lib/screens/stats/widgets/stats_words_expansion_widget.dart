import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/durations.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../models/round/round.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../../widgets/scores/played_word_value.dart';

class StatsWordsExpansionWidget extends StatefulWidget {
  final int index;
  final Round round;
  final String someWords;
  final bool quickGameStats;

  const StatsWordsExpansionWidget({
    required this.index,
    required this.round,
    required this.someWords,
    this.quickGameStats = false,
  });

  @override
  State<StatsWordsExpansionWidget> createState() => _StatsWordsExpansionWidgetState();
}

class _StatsWordsExpansionWidgetState extends State<StatsWordsExpansionWidget> with TickerProviderStateMixin {
  var showSubtitle = true;
  var turns = 0.25;
  var isPlaying = false;

  PlayerController? audioController;
  late final AnimationController iconAnimationController;
  late final AnimationController scaleAnimationController;
  late final Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    initializeAnimations();
    initializeAudio();
    setState(() {});
  }

  Future<void> initializeAnimations() async {
    /// Icon toggle animation (play / pause)
    iconAnimationController = AnimationController(
      duration: ModerniAliasDurations.animation,
      vsync: this,
    );

    /// Scale icon animation (play / pause)
    scaleAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1, end: 1.25).animate(
      CurvedAnimation(
        parent: scaleAnimationController,
        curve: Curves.easeIn,
      ),
    );

    await scaleAnimationController.repeat(reverse: true);
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
    switch (audioController?.playerState) {
      case PlayerState.initialized:
        await audioController?.startPlayer(finishMode: FinishMode.pause);
        break;
      case PlayerState.paused:
        await audioController?.startPlayer(finishMode: FinishMode.pause);
        break;
      case PlayerState.playing:
        await audioController?.pausePlayer();
        break;
      case PlayerState.stopped:
        await audioController?.startPlayer(finishMode: FinishMode.pause);
        break;

      default:
        await audioController?.startPlayer(finishMode: FinishMode.pause);
    }
  }

  /// Animates the play / pause icon forward
  void animateForward() {
    if (mounted) {
      iconAnimationController.forward();
      scaleAnimationController.stop();
      isPlaying = true;
    }
  }

  /// Animates the play / pause icon backward
  void animateBackward() {
    if (mounted) {
      iconAnimationController.reverse();
      scaleAnimationController.repeat(reverse: true);
      isPlaying = false;
    }
  }

  /// Widgets which are shown when opening expansion tile / when viewing [QuickGameStats]
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
                Expanded(
                  child: AudioFileWaveforms(
                    size: Size(MediaQuery.sizeOf(context).width, 48),
                    playerController: audioController!,
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
                    onTap: () {},
                    child: AnimatedBuilder(
                      animation: scaleAnimation,
                      builder: (_, child) => Transform.scale(
                        scale: scaleAnimation.value,
                        child: child,
                      ),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: iconAnimationController,
                        color: ModerniAliasColors.white,
                        size: 48,
                      ),
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
      shape: const RoundedRectangleBorder(),
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
          ModerniAliasIcons.arrowStatsImage,
          color: ModerniAliasColors.white,
          height: 26,
          width: 26,
        ),
      ),
      children: buildExpansionTileChildren(),
    );
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    scaleAnimationController.dispose();
    audioController?.dispose();
    super.dispose();
  }
}
