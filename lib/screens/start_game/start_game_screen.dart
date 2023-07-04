import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import './widgets/length_of_round_button.dart';
import './widgets/name_of_team.dart';
import './widgets/number_of_points.dart';
import './widgets/number_of_teams_button.dart';
import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../services/dictionary_service.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_list_view.dart';
import '../../widgets/background_image.dart';
import '../../widgets/flag_button.dart';
import '../../widgets/game_title.dart';
import '../../widgets/play_button.dart';
import 'start_game_controller.dart';
import 'widgets/horizontal_row.dart';
import 'widgets/show_custom_value_sheet.dart';

class StartGameScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenDictionary = ref.watch(chosenDictionaryProvider);
    final teams = ref.watch(teamsProvider);
    final teamsLength = ref.watch(teamsLengthProvider);
    final pointsToWin = ref.watch(pointsToWinProvider);
    final lengthOfRound = ref.watch(lengthOfRoundProvider);
    final validationMessage = ref.watch(validationMessageProvider);

    final startGameController = ref.watch(startGameProvider);

    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GameTitle('dictionaryString'.tr()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createFlagButton(
                        countryName: 'dictionaryCroatianString'.tr(),
                        flagImage: ModerniAliasIcons.croatiaImage,
                        selectedCountry: Flag.croatia,
                        onTap: () => startGameController.updateDictionary(Flag.croatia),
                        isActive: chosenDictionary == Flag.croatia,
                      ),
                      createFlagButton(
                        countryName: 'dictionaryEnglishString'.tr(),
                        flagImage: ModerniAliasIcons.unitedKingdomImage,
                        selectedCountry: Flag.unitedKingdom,
                        onTap: () => startGameController.updateDictionary(Flag.unitedKingdom),
                        isActive: chosenDictionary == Flag.unitedKingdom,
                      ),
                    ],
                  ),
                  GameTitle('teamsString'.tr()),
                  HorizontalScroll(
                    [
                      createNumberOfTeamsButton(
                        value: '2',
                        onTap: () => startGameController.updateNumberOfTeams(
                          chosenNumber: 2,
                        ),
                        isActive: teamsLength == 2,
                      ),
                      createNumberOfTeamsButton(
                        value: '3',
                        onTap: () => startGameController.updateNumberOfTeams(
                          chosenNumber: 3,
                        ),
                        isActive: teamsLength == 3,
                      ),
                      createNumberOfTeamsButton(
                        value: '4',
                        onTap: () => startGameController.updateNumberOfTeams(
                          chosenNumber: 4,
                        ),
                        isActive: teamsLength == 4,
                      ),
                      createNumberOfTeamsButton(
                        value: teamsLength < 5 ? '•••' : '$teamsLength',
                        onTap: () => showCustomValueSheet(
                          title: 'teamsString'.tr(),
                          hintText: '${'numberBetweenString'.tr()} 2 - 10',
                          onValueSaved: (value) => startGameController.updateNumberOfTeams(
                            chosenNumber: value,
                          ),
                          lowestNumber: 2,
                          highestNumber: 10,
                          context: context,
                        ),
                        isActive: teamsLength >= 5,
                      ),
                    ],
                  ),
                  GameTitle('numberOfPointsString'.tr()),
                  HorizontalScroll(
                    [
                      createNumberOfPointsButton(
                        value: '25',
                        onTap: () => ref.read(pointsToWinProvider.notifier).state = 25,
                        isActive: pointsToWin == 25,
                      ),
                      createNumberOfPointsButton(
                        value: '50',
                        onTap: () => ref.read(pointsToWinProvider.notifier).state = 50,
                        isActive: pointsToWin == 50,
                      ),
                      createNumberOfPointsButton(
                        value: '75',
                        onTap: () => ref.read(pointsToWinProvider.notifier).state = 75,
                        isActive: pointsToWin == 75,
                      ),
                      createNumberOfPointsButton(
                        value: '100',
                        onTap: () => ref.read(pointsToWinProvider.notifier).state = 100,
                        isActive: pointsToWin == 100,
                      ),
                      createNumberOfPointsButton(
                        value: pointsToWin == 25 || pointsToWin == 50 || pointsToWin == 75 || pointsToWin == 100 ? '•••' : '$pointsToWin',
                        onTap: () => showCustomValueSheet(
                          title: 'numberOfPointsString'.tr(),
                          hintText: '${'numberBetweenString'.tr()} 5 - 1000',
                          onValueSaved: (value) => ref.read(pointsToWinProvider.notifier).state = value,
                          lowestNumber: 5,
                          highestNumber: 1000,
                          context: context,
                        ),
                        isActive: pointsToWin != 25 && pointsToWin != 50 && pointsToWin != 75 && pointsToWin != 100,
                      ),
                    ],
                  ),
                  GameTitle('lengthOfRoundString'.tr()),
                  HorizontalScroll(
                    [
                      createLengthOfRoundButton(
                        value: '20',
                        onTap: () => ref.read(lengthOfRoundProvider.notifier).state = 20,
                        isActive: lengthOfRound == 20,
                      ),
                      createLengthOfRoundButton(
                        value: '45',
                        onTap: () => ref.read(lengthOfRoundProvider.notifier).state = 45,
                        isActive: lengthOfRound == 45,
                      ),
                      createLengthOfRoundButton(
                        value: '60',
                        onTap: () => ref.read(lengthOfRoundProvider.notifier).state = 60,
                        isActive: lengthOfRound == 60,
                      ),
                      createLengthOfRoundButton(
                        value: '90',
                        onTap: () => ref.read(lengthOfRoundProvider.notifier).state = 90,
                        isActive: lengthOfRound == 90,
                      ),
                      createLengthOfRoundButton(
                        value: lengthOfRound == 20 || lengthOfRound == 45 || lengthOfRound == 60 || lengthOfRound == 90 ? '•••' : '$lengthOfRound',
                        onTap: () => showCustomValueSheet(
                          title: 'lengthOfRoundString'.tr(),
                          hintText: '${'numberBetweenString'.tr()} 5 - 1000',
                          onValueSaved: (value) => ref.read(lengthOfRoundProvider.notifier).state = value,
                          lowestNumber: 5,
                          highestNumber: 1000,
                          context: context,
                        ),
                        isActive: lengthOfRound != 20 && lengthOfRound != 45 && lengthOfRound != 60 && lengthOfRound != 90,
                      ),
                    ],
                  ),
                  GameTitle('teamNamesString'.tr()),
                  AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: teamsLength,
                      itemBuilder: (_, index) {
                        final team = teams[index];

                        return AnimatedListView(
                          fastAnimations: true,
                          index: index,
                          child: NameOfTeam(
                            textEditingController: team.textEditingController,
                            key: ValueKey(team),
                            hintText: 'teamNameString'.tr(),
                            textInputAction: index == teamsLength - 1 ? TextInputAction.done : TextInputAction.next,
                            onChanged: (value) => startGameController.teamNameUpdated(
                              passedTeam: team,
                              value: value,
                            ),
                            randomizePressed: () => startGameController.randomizeTeamName(
                              passedTeam: team,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.animation,
                        child: Text(
                          key: ValueKey(validationMessage),
                          validationMessage ?? '',
                          style: ModerniAliasTextStyles.validation,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: PlayButton(
                      text: 'playTheGameString'.tr().toUpperCase(),
                      onPressed: () {
                        /// Validation successfull, go to [NormalGameScreen]
                        if (startGameController.validateTeams()) {
                          goToNormalGameScreen(context);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
