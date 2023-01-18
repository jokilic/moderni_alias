import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './exit_game_button.dart';
import '../constants/strings.dart';
import '../constants/text_styles.dart';
import '../services/game_service.dart';
import 'animated_column.dart';

Future<bool> exitGameModal() async {
  final gameService = Get.find<GameService>();

  await Get.bottomSheet(
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 36.h,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            ModerniAliasImages.backgroundImage,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: AnimatedColumn(
        fastAnimations: true,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'exitModalQuestionString'.tr,
            textAlign: TextAlign.center,
            style: ModerniAliasTextStyles.exitModal,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExitGameButton(
                text: 'exitModalQuestionYes'.tr,
                animationController: gameService.exitButtonAnimationController,
                pointerDown: (_) => gameService.exitButtonAnimationController.forward(),
                pointerUp: (_) => gameService.exitButtonAnimationController.reverse(),
              ),
              SizedBox(width: 24.h),
              ExitGameButton(
                text: 'exitModalQuestionNo'.tr,
                onPressed: Get.back,
              ),
            ],
          ),
        ],
      ),
    ),
  );

  /// Reset animation when dismissing modal
  gameService.exitButtonAnimationController.value = 0;
  return false;
}
