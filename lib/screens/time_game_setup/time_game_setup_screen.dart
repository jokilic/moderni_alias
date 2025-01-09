import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../services/dictionary_service.dart';
import '../../controllers/game_logic_controller.dart';
import '../../util/providers.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_list_view.dart';
import '../../widgets/background_image.dart';
import '../../widgets/flag_button.dart';
import '../../widgets/game_setup/horizontal_row.dart';
import '../../widgets/game_setup/name_of_team.dart';
import '../../widgets/game_setup/number_of_teams_button.dart';
import '../../widgets/game_setup/number_of_time_points.dart';
import '../../widgets/game_setup/show_custom_value_sheet.dart';
import '../../widgets/game_title.dart';
import '../../widgets/play_button.dart';

class TimeGameSetupScreen extends StatelessWidget {
  const TimeGameSetupScreen({required super.key});

  @override
  Widget build(BuildContext context) {
    final chosenDictionary = ref.watch(chosenDictionaryProvider);
    final teams = ref.watch(teamsProvider);
    final teamsLength = ref.watch(teamsLengthProvider);
    final wordsToWin = ref.watch(wordsToWinProvider);
    final validationMessage = ref.watch(validationMessageProvider);

    final gameSetupController = ref.watch(gameSetupProvider);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
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
                          onTap: () => gameSetupController.updateDictionary(Flag.croatia),
                          isActive: chosenDictionary == Flag.croatia,
                        ),
                        createFlagButton(
                          countryName: 'dictionaryEnglishString'.tr(),
                          flagImage: ModerniAliasIcons.unitedKingdomImage,
                          selectedCountry: Flag.unitedKingdom,
                          onTap: () => gameSetupController.updateDictionary(Flag.unitedKingdom),
                          isActive: chosenDictionary == Flag.unitedKingdom,
                        ),
                      ],
                    ),
                    GameTitle('teamsString'.tr()),
                    HorizontalScroll(
                      [
                        createNumberOfTeamsButton(
                          value: '2',
                          onTap: () => gameSetupController.updateNumberOfTeams(
                            chosenNumber: 2,
                          ),
                          isActive: teamsLength == 2,
                        ),
                        createNumberOfTeamsButton(
                          value: '3',
                          onTap: () => gameSetupController.updateNumberOfTeams(
                            chosenNumber: 3,
                          ),
                          isActive: teamsLength == 3,
                        ),
                        createNumberOfTeamsButton(
                          value: '4',
                          onTap: () => gameSetupController.updateNumberOfTeams(
                            chosenNumber: 4,
                          ),
                          isActive: teamsLength == 4,
                        ),
                        createNumberOfTeamsButton(
                          value: teamsLength < 5 ? '•••' : '$teamsLength',
                          onTap: () => showCustomValueSheet(
                            title: 'teamsString'.tr(),
                            hintText: '${'numberBetweenString'.tr()} 2 - 10',
                            onValueSaved: (value) => gameSetupController.updateNumberOfTeams(
                              chosenNumber: value,
                            ),
                            lowestNumber: 2,
                            highestNumber: 10,
                            backgroundImage: ref.watch(backgroundImageProvider),
                            context: context,
                          ),
                          isActive: teamsLength >= 5,
                        ),
                      ],
                    ),
                    GameTitle('numberOfWordsString'.tr()),
                    HorizontalScroll(
                      [
                        createNumberOfTimePointsButton(
                          value: '5',
                          onTap: () => ref.read(wordsToWinProvider.notifier).state = 5,
                          isActive: wordsToWin == 5,
                        ),
                        createNumberOfTimePointsButton(
                          value: '10',
                          onTap: () => ref.read(wordsToWinProvider.notifier).state = 10,
                          isActive: wordsToWin == 10,
                        ),
                        createNumberOfTimePointsButton(
                          value: '25',
                          onTap: () => ref.read(wordsToWinProvider.notifier).state = 25,
                          isActive: wordsToWin == 25,
                        ),
                        createNumberOfTimePointsButton(
                          value: '50',
                          onTap: () => ref.read(wordsToWinProvider.notifier).state = 50,
                          isActive: wordsToWin == 50,
                        ),
                        createNumberOfTimePointsButton(
                          value: wordsToWin == 5 || wordsToWin == 10 || wordsToWin == 25 || wordsToWin == 50 ? '•••' : '$wordsToWin',
                          onTap: () => showCustomValueSheet(
                            title: 'numberOfWordsString'.tr(),
                            hintText: '${'numberBetweenString'.tr()} 2 - 100',
                            onValueSaved: (value) => ref.read(wordsToWinProvider.notifier).state = value,
                            lowestNumber: 2,
                            highestNumber: 100,
                            backgroundImage: ref.watch(backgroundImageProvider),
                            context: context,
                          ),
                          isActive: wordsToWin != 5 && wordsToWin != 10 && wordsToWin != 25 && wordsToWin != 50,
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
                              onChanged: (value) => gameSetupController.teamNameUpdated(
                                passedTeam: team,
                                value: value,
                              ),
                              randomizePressed: () => gameSetupController.randomizeTeamName(
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
                          /// Validation successfull, go to [TimeGameScreen]
                          if (gameSetupController.validateTeams()) {
                            openTimeGame(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
