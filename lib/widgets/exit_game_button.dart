import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';
import '../constants/durations.dart';
import '../constants/text_styles.dart';
import '../util/providers.dart';
import '../util/routing.dart';
import 'animated_gesture_detector.dart';

class ExitGameButton extends ConsumerStatefulWidget {
  final String text;
  final Function()? onPressed;

  const ExitGameButton({
    required this.text,
    this.onPressed,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExitGameButtonState();
}

class _ExitGameButtonState extends ConsumerState<ExitGameButton> with SingleTickerProviderStateMixin {
  String? bottomText;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    if (widget.onPressed == null) {
      controller = AnimationController(
        vsync: this,
        duration: ModerniAliasDurations.slowAnimation,
      )..addStatusListener(
          (status) {
            /// User stopped holding the button, show message
            if (status == AnimationStatus.reverse) {
              bottomText = 'exitModalQuestionHoldMe'.tr();
              Future.delayed(
                ModerniAliasDurations.verySlowAnimation,
                () => setState(() => bottomText = null),
              );
            }

            /// Animation is completed, exit game
            if (status == AnimationStatus.completed) {
              ref.read(countdownPlayerProvider).stop();
              goToHomeScreen(context);
            }
          },
        );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Listener(
        onPointerDown: (_) => widget.onPressed == null ? controller?.forward() : null,
        onPointerUp: (_) => widget.onPressed == null ? controller?.reverse() : null,
        child: widget.onPressed == null && controller != null
            ? AnimatedBuilder(
                animation: controller!,
                builder: (_, child) => Container(
                  decoration: BoxDecoration(
                    color: ModerniAliasColors.white.withOpacity(
                      controller!.value,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ExitTextButton(
                    animationController: controller,
                    onPressed: widget.onPressed,
                    text: widget.text,
                    bottomText: bottomText,
                  ),
                ),
              )
            : ExitTextButton(
                onPressed: widget.onPressed,
                text: widget.text,
                bottomText: bottomText,
              ),
      );
}

class ExitTextButton extends StatelessWidget {
  final String text;
  final String? bottomText;
  final Function()? onPressed;
  final AnimationController? animationController;

  const ExitTextButton({
    required this.text,
    this.bottomText,
    this.onPressed,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: animationController == null ? onPressed : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextButton(
              onPressed: null,
              style: TextButton.styleFrom(
                foregroundColor: ModerniAliasColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                side: const BorderSide(
                  color: ModerniAliasColors.white,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 16,
                ),
                child: AnimatedOpacity(
                  duration: ModerniAliasDurations.fastAnimation,
                  curve: Curves.easeIn,
                  opacity: bottomText != null ? 0 : 1,
                  child: Text(
                    text.toUpperCase(),
                    style: ModerniAliasTextStyles.exitButton,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: ModerniAliasDurations.fastAnimation,
              curve: Curves.easeIn,
              opacity: bottomText != null ? 1 : 0,
              child: Text(
                bottomText ?? '',
                style: ModerniAliasTextStyles.holdMeExitButton,
              ),
            ),
          ],
        ),
      );
}
