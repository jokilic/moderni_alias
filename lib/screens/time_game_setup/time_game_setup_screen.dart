import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../models/team/team.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
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
import 'time_game_setup_controller.dart';

class TimeGameSetupScreen extends WatchingStatefulWidget {
  const TimeGameSetupScreen({required super.key});

  @override
  State<TimeGameSetupScreen> createState() => _TimeGameSetupScreenState();
}

class _TimeGameSetupScreenState extends State<TimeGameSetupScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<TimeGameSetupController>(
      () => TimeGameSetupController(
        logger: getIt.get<LoggerService>(),
        dictionary: getIt.get<DictionaryService>(),
      ),
    );
  }

  @override
  void dispose() {
    getIt.unregister<TimeGameSetupController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chosenDictionary = watchIt<DictionaryService>().value.chosenLanguage;
    final backgroundImage = watchIt<BackgroundImageService>().value;

    final state = watchIt<TimeGameSetupController>().value;
    final teams = state.teams;
    final wordsToWin = state.wordsToWin;
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
                                onTap: () => getIt.get<TimeGameSetupController>().updateState(
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
                            onValueSaved: (value) => getIt.get<TimeGameSetupController>().updateState(
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
                    GameTitle('numberOfWordsString'.tr()),
                    HorizontalScroll(
                      [
                        ...[5, 10, 25, 50]
                            .map(
                              (element) => createNumberOfTimePointsButton(
                                value: '$element',
                                onTap: () => getIt.get<TimeGameSetupController>().updateState(newWordsToWin: element),
                                isActive: wordsToWin == element,
                              ),
                            )
                            .toList(),
                        createNumberOfTimePointsButton(
                          value: wordsToWin == 5 || wordsToWin == 10 || wordsToWin == 25 || wordsToWin == 50 ? '•••' : '$wordsToWin',
                          onTap: () => showCustomValueSheet(
                            title: 'numberOfWordsString'.tr(),
                            hintText: '${'numberBetweenString'.tr()} 2 - 100',
                            onValueSaved: (value) => getIt.get<TimeGameSetupController>().updateState(newWordsToWin: value),
                            lowestNumber: 2,
                            highestNumber: 100,
                            backgroundImage: backgroundImage,
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
                              onChanged: (value) => getIt.get<TimeGameSetupController>().teamNameUpdated(
                                    passedTeam: team,
                                    newName: value,
                                  ),
                              randomizePressed: () => getIt.get<TimeGameSetupController>().randomizeTeamName(
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
                          final isValidated = getIt.get<TimeGameSetupController>().validateTeams();

                          /// Validation successful, go to [TimeGameScreen]
                          if (isValidated) {
                            openTimeGame(
                              context,
                              teams: teams,
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
