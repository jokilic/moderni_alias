import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './highscore_value.dart';
import '../../../constants/strings.dart';
import '../main_game_screen.dart';

void showScores(BuildContext context) => Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 36,
          bottom: 24,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              scoresModalString,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 24),
            ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) => HighscoreValue(
                teamName: teams[index].name,
                points: teams[index].points,
              ),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
