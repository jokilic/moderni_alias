import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import './widgets/length_of_round_button.dart';
import './widgets/name_of_team.dart';
import './widgets/number_of_points.dart';
import './widgets/number_of_teams_button.dart';
import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../models/arguments/normal_game_arguments.dart';
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

class StartGameScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenDictionary = ref.watch(chosenDictionaryProvider);
    final teams = ref.watch(teamsProvider);
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
                        flagImage: ModerniAliasImages.croatiaImage,
                        selectedCountry: Flag.croatia,
                        updateValue: () => startGameController.updateDictionary(Flag.croatia),
                        isActive: chosenDictionary == Flag.croatia,
                      ),
                      createFlagButton(
                        countryName: 'dictionaryEnglishString'.tr(),
                        flagImage: ModerniAliasImages.unitedKingdomImage,
                        selectedCountry: Flag.unitedKingdom,
                        updateValue: () => startGameController.updateDictionary(Flag.unitedKingdom),
                        isActive: chosenDictionary == Flag.unitedKingdom,
                      ),
                    ],
                  ),
                  GameTitle('teamsString'.tr()),
                  HorizontalScroll(
                    [
                      createNumberOfTeamsButton(
                        chosenNumberOfTeams: 2,
                        updateValue: () => startGameController.updateNumberOfTeams(
                          chosenNumber: 2,
                        ),
                        isActive: teams.length == 2,
                      ),
                      createNumberOfTeamsButton(
                        chosenNumberOfTeams: 3,
                        updateValue: () => startGameController.updateNumberOfTeams(
                          chosenNumber: 3,
                        ),
                        isActive: teams.length == 3,
                      ),
                      createNumberOfTeamsButton(
                        chosenNumberOfTeams: 4,
                        updateValue: () => startGameController.updateNumberOfTeams(
                          chosenNumber: 4,
                        ),
                        isActive: teams.length == 4,
                      ),
                    ],
                  ),
                  GameTitle('numberOfPointsString'.tr()),
                  HorizontalScroll(
                    [
                      createNumberOfPointsButton(
                        chosenNumberOfPoints: 25,
                        updateValue: () => ref.read(pointsToWinProvider.notifier).state = 25,
                        isActive: pointsToWin == 25,
                      ),
                      createNumberOfPointsButton(
                        chosenNumberOfPoints: 50,
                        updateValue: () => ref.read(pointsToWinProvider.notifier).state = 50,
                        isActive: pointsToWin == 50,
                      ),
                      createNumberOfPointsButton(
                        chosenNumberOfPoints: 75,
                        updateValue: () => ref.read(pointsToWinProvider.notifier).state = 75,
                        isActive: pointsToWin == 75,
                      ),
                      createNumberOfPointsButton(
                        chosenNumberOfPoints: 100,
                        updateValue: () => ref.read(pointsToWinProvider.notifier).state = 100,
                        isActive: pointsToWin == 100,
                      ),
                    ],
                  ),
                  GameTitle('lengthOfRoundString'.tr()),
                  HorizontalScroll(
                    [
                      createLengthOfRoundButton(
                        chosenLengthOfRound: 20,
                        updateValue: () => ref.read(lengthOfRoundProvider.notifier).state = 20,
                        isActive: lengthOfRound == 20,
                      ),
                      createLengthOfRoundButton(
                        chosenLengthOfRound: 45,
                        updateValue: () => ref.read(lengthOfRoundProvider.notifier).state = 45,
                        isActive: lengthOfRound == 45,
                      ),
                      createLengthOfRoundButton(
                        chosenLengthOfRound: 60,
                        updateValue: () => ref.read(lengthOfRoundProvider.notifier).state = 60,
                        isActive: lengthOfRound == 60,
                      ),
                      createLengthOfRoundButton(
                        chosenLengthOfRound: 90,
                        updateValue: () => ref.read(lengthOfRoundProvider.notifier).state = 90,
                        isActive: lengthOfRound == 90,
                      ),
                    ],
                  ),
                  GameTitle('teamNamesString'.tr()),
                  AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: teams.length,
                      itemBuilder: (context, index) {
                        final team = teams[index];

                        return AnimatedListView(
                          fastAnimations: true,
                          index: index,
                          child: NameOfTeam(
                            key: ValueKey(team),
                            hintText: 'teamNameString'.tr(),
                            textInputAction: index == teams.length - 1 ? TextInputAction.done : TextInputAction.next,
                            onChanged: (value) => startGameController.teamNameUpdated(
                              passedTeam: team,
                              value: value,
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
                        if (startGameController.validateMainGame()) {
                          goToNormalGameScreen(
                            context,
                            arguments: NormalGameArguments(
                              chosenDictionary: chosenDictionary,
                              teams: teams,
                              pointsToWin: pointsToWin,
                              lengthOfRound: lengthOfRound,
                            ),
                          );
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
