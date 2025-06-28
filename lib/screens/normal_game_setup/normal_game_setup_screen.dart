import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../controllers/base_game_setup_controller.dart';
import '../../models/team/team.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/animated_list_view.dart';
import '../../widgets/background_image.dart';
import '../../widgets/flag_button.dart';
import '../../widgets/game_setup/horizontal_row.dart';
import '../../widgets/game_setup/length_of_round_button.dart';
import '../../widgets/game_setup/name_of_team.dart';
import '../../widgets/game_setup/number_of_points.dart';
import '../../widgets/game_setup/number_of_teams_button.dart';
import '../../widgets/game_setup/show_custom_value_sheet.dart';
import '../../widgets/game_title.dart';
import '../../widgets/play_button.dart';
import 'normal_game_setup_controller.dart';

class NormalGameSetupScreen extends WatchingStatefulWidget {
  @override
  State<NormalGameSetupScreen> createState() => _NormalGameSetupScreenState();
}

class _NormalGameSetupScreenState extends State<NormalGameSetupScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<BaseGameSetupController>(
      () => BaseGameSetupController(
        logger: getIt.get<LoggerService>(),
        dictionary: getIt.get<DictionaryService>(),
      ),
    );

    registerIfNotInitialized<NormalGameSetupController>(
      () => NormalGameSetupController(
        logger: getIt.get<LoggerService>(),
      ),
    );
  }

  @override
  void dispose() {
    unregisterIfInitialized<BaseGameSetupController>();
    unregisterIfInitialized<NormalGameSetupController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chosenDictionary = watchIt<DictionaryService>().value;
    final backgroundImage = watchIt<BackgroundImageService>().value;

    final state = watchIt<NormalGameSetupController>().value;
    final teams = state.teams;
    final pointsToWin = state.pointsToWin;
    final lengthOfRound = state.lengthOfRound;
    final validationMessage = state.validationMessage;

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
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedGestureDetector(
                        onTap: Navigator.of(context).pop,
                        end: 0.8,
                        child: IconButton(
                          onPressed: null,
                          icon: Transform.rotate(
                            angle: pi,
                            child: Image.asset(
                              ModerniAliasIcons.arrowStatsImage,
                              color: ModerniAliasColors.white,
                              height: 26,
                              width: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GameTitle('dictionaryString'.tr()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        createFlagButton(
                          countryName: 'dictionaryCroatianString'.tr(),
                          flagImage: ModerniAliasIcons.croatiaImage,
                          selectedCountry: Flag.croatia,
                          onTap: () => getIt.get<DictionaryService>().updateActiveDictionary(newLanguage: Flag.croatia),
                          isActive: chosenDictionary == Flag.croatia,
                        ),
                        createFlagButton(
                          countryName: 'dictionaryEnglishString'.tr(),
                          flagImage: ModerniAliasIcons.unitedKingdomImage,
                          selectedCountry: Flag.unitedKingdom,
                          onTap: () => getIt.get<DictionaryService>().updateActiveDictionary(newLanguage: Flag.unitedKingdom),
                          isActive: chosenDictionary == Flag.unitedKingdom,
                        ),
                      ],
                    ),
                    GameTitle('teamsString'.tr()),
                    HorizontalScroll(
                      [
                        ...[2, 3, 4]
                            .map(
                              (element) => createNumberOfTeamsButton(
                                value: '$element',
                                onTap: () => getIt.get<NormalGameSetupController>().updateState(
                                  newTeams: List.generate(
                                    element,
                                    (_) => Team(
                                      name: '',
                                      textEditingController: TextEditingController(),
                                    ),
                                  ),
                                ),
                                isActive: teams.length == element,
                              ),
                            )
                            .toList(),
                        createNumberOfTeamsButton(
                          value: teams.length < 5 ? '•••' : '${teams.length}',
                          onTap: () => showCustomValueSheet(
                            title: 'teamsString'.tr(),
                            hintText: '${'numberBetweenString'.tr()} 2 - 10',
                            onValueSaved: (value) => getIt.get<NormalGameSetupController>().updateState(
                              newTeams: List.generate(
                                value,
                                (_) => Team(
                                  name: '',
                                  textEditingController: TextEditingController(),
                                ),
                              ),
                            ),
                            lowestNumber: 2,
                            highestNumber: 10,
                            backgroundImage: backgroundImage,
                            context: context,
                          ),
                          isActive: teams.length >= 5,
                        ),
                      ],
                    ),
                    GameTitle('numberOfPointsString'.tr()),
                    HorizontalScroll(
                      [
                        ...[25, 50, 75, 100]
                            .map(
                              (element) => createNumberOfPointsButton(
                                value: '$element',
                                onTap: () => getIt.get<NormalGameSetupController>().updateState(newPointsToWin: element),
                                isActive: pointsToWin == element,
                              ),
                            )
                            .toList(),
                        createNumberOfPointsButton(
                          value: pointsToWin == 25 || pointsToWin == 50 || pointsToWin == 75 || pointsToWin == 100 ? '•••' : '$pointsToWin',
                          onTap: () => showCustomValueSheet(
                            title: 'numberOfPointsString'.tr(),
                            hintText: '${'numberBetweenString'.tr()} 5 - 1000',
                            onValueSaved: (value) => getIt.get<NormalGameSetupController>().updateState(newPointsToWin: value),
                            lowestNumber: 5,
                            highestNumber: 1000,
                            backgroundImage: backgroundImage,
                            context: context,
                          ),
                          isActive: pointsToWin != 25 && pointsToWin != 50 && pointsToWin != 75 && pointsToWin != 100,
                        ),
                      ],
                    ),
                    GameTitle('lengthOfRoundString'.tr()),
                    HorizontalScroll(
                      [
                        ...[20, 45, 60, 90]
                            .map(
                              (element) => createLengthOfRoundButton(
                                value: '$element',
                                onTap: () => getIt.get<NormalGameSetupController>().updateState(newLengthOfRound: element),
                                isActive: lengthOfRound == element,
                              ),
                            )
                            .toList(),
                        createLengthOfRoundButton(
                          value: lengthOfRound == 20 || lengthOfRound == 45 || lengthOfRound == 60 || lengthOfRound == 90 ? '•••' : '$lengthOfRound',
                          onTap: () => showCustomValueSheet(
                            title: 'lengthOfRoundString'.tr(),
                            hintText: '${'numberBetweenString'.tr()} 5 - 1000',
                            onValueSaved: (value) => getIt.get<NormalGameSetupController>().updateState(newLengthOfRound: value),
                            lowestNumber: 5,
                            highestNumber: 1000,
                            backgroundImage: backgroundImage,
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
                        itemCount: teams.length,
                        itemBuilder: (_, index) {
                          final team = teams[index];

                          return AnimatedListView(
                            fastAnimations: true,
                            index: index,
                            child: NameOfTeam(
                              textEditingController: team.textEditingController,
                              key: ValueKey(team),
                              hintText: 'teamNameString'.tr(),
                              textInputAction: index == teams.length - 1 ? TextInputAction.done : TextInputAction.next,
                              onChanged: (value) => getIt.get<BaseGameSetupController>().onChangedTeamName(
                                passedTeam: team,
                                newName: value,
                              ),
                              randomizePressed: () => getIt.get<BaseGameSetupController>().randomizeTeamName(
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
                          /// Validate teams
                          final validationError = getIt.get<BaseGameSetupController>().validateTeams(
                            teams: teams,
                          );

                          /// Validation successful, go to [NormalGameScreen]
                          if (validationError == null) {
                            openNormalGame(
                              context,
                              teams: teams,
                              pointsToWin: pointsToWin,
                              lengthOfRound: lengthOfRound,
                            );
                          }
                          /// Validation not successful, show error
                          else {
                            getIt.get<NormalGameSetupController>().updateState(
                              newValidationMessage: validationError,
                            );
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
