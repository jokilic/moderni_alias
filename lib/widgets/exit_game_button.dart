import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/text_styles.dart';
import '../util/routing.dart';
import 'animated_gesture_detector.dart';

class ExitGameButton extends StatefulWidget {
  final String text;
  final Function()? onPressed;

  const ExitGameButton({
    required this.text,
    this.onPressed,
  });

  @override
  State<ExitGameButton> createState() => _ExitGameButtonState();
}

class _ExitGameButtonState extends State<ExitGameButton> with SingleTickerProviderStateMixin {
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
            /// Animation is completed, exit game
            if (status == AnimationStatus.completed) {
              goToHomeScreen(context, popEverything: true);
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
                    color: ModerniAliasColors.whiteColor.withOpacity(
                      controller!.value,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ExitTextButton(
                    animationController: controller,
                    onPressed: widget.onPressed,
                    text: widget.text,
                  ),
                ),
              )
            : ExitTextButton(
                onPressed: widget.onPressed,
                text: widget.text,
              ),
      );
}

class ExitTextButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final AnimationController? animationController;

  const ExitTextButton({
    required this.text,
    this.onPressed,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: animationController == null ? onPressed : null,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            foregroundColor: ModerniAliasColors.whiteColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 2,
            ),
            side: const BorderSide(
              color: ModerniAliasColors.whiteColor,
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
            child: Text(
              text.toUpperCase(),
              style: ModerniAliasTextStyles.exitButton,
            ),
          ),
        ),
      );
}
