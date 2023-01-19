import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'animated_gesture_detector.dart';

class ExitGameButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final AnimationController? animationController;
  final Function(PointerDownEvent event)? pointerDown;
  final Function(PointerUpEvent event)? pointerUp;

  const ExitGameButton({
    required this.text,
    this.onPressed,
    this.animationController,
    this.pointerDown,
    this.pointerUp,
  });

  @override
  Widget build(BuildContext context) => Listener(
        onPointerDown: animationController != null ? pointerDown : null,
        onPointerUp: animationController != null ? pointerUp : null,
        child: animationController != null
            ? AnimatedBuilder(
                animation: animationController!,
                builder: (_, child) => Container(
                  decoration: BoxDecoration(
                    color: ModerniAliasColors.whiteColor.withOpacity(
                      animationController!.value,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: ExitTextButton(
                    animationController: animationController,
                    onPressed: onPressed,
                    text: text,
                  ),
                ),
              )
            : ExitTextButton(
                animationController: animationController,
                onPressed: onPressed,
                text: text,
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
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 2.h,
            ),
            side: BorderSide(
              color: ModerniAliasColors.whiteColor,
              width: 2.w,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 36.w,
              vertical: 16.h,
            ),
            child: Text(
              text.toUpperCase(),
              style: ModerniAliasTextStyles.exitButton,
            ),
          ),
        ),
      );
}
