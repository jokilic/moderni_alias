import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './widgets/horizontal_row.dart';
import './widgets/length_of_round_button.dart';
import './widgets/name_of_team.dart';
import './widgets/number_of_points.dart';
import './widgets/number_of_teams_button.dart';
import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/flag_button.dart';
import '../../widgets/game_title.dart';
import '../../widgets/play_button.dart';

class StartGameScreen extends StatelessWidget {
  static const routeName = '/start-game-screen';

// Called when tapping on the 'Igraj' button
  // void validateSetGo() {
  //   teamNames.clear();
  //   textFieldControllers.map((controller) => teamNames.add(controller.text)).toList();

  //   validateTextFields(textFieldControllers);

  //   routeArguments = {
  //     'pointsToWin': pointsToWin.toString(),
  //     'lengthOfRound': lengthOfRound.toString(),
  //     'numOfTeams': numOfTeamsValue.toString(),
  //     'team1': teamNames[0],
  //     'team2': teamNames[1],
  //   };

  //   if (numOfTeamsValue == 3) {
  //     routeArguments['team3'] = teamNames[2];
  //   }
  //   if (numOfTeamsValue == 4) {
  //     routeArguments['team4'] = teamNames[3];
  //   }

  //   if (validated) {
  //     FocusScope.of(context).unfocus();

  //     Get.toNamed(MainGameScreen.routeName);
  //   }
  // }

// Validate if all TextFields have values
  // void validateTextFields(textFieldControllers) {
  //   validationCounter = 0;
  //   textFieldControllers.forEach((controller) {
  //     if (controller.text.isEmpty) {
  //       validationCounter++;
  //     }
  //   });

  //   focusNodes.clear();
  //   textFieldControllers.clear();

  //   validationCounter > 0 ? validated = false : validated = true;
  // }

  final gameService = Get.find<GameService>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: Obx(
                () => ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    GameTitle('dictionaryString'.tr),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        createFlagButton(
                          countryName: 'dictionaryCroatianString'.tr,
                          flagImage: croatiaImage,
                          selectedCountry: Flag.croatia,
                          updateValue: () => gameService.updateDictionary(Flag.croatia),
                          isActive: gameService.chosenDictionary == Flag.croatia,
                        ),
                        createFlagButton(
                          countryName: 'dictionaryEnglishString'.tr,
                          flagImage: unitedKingdomImage,
                          selectedCountry: Flag.unitedKingdom,
                          updateValue: () => gameService.updateDictionary(Flag.unitedKingdom),
                          isActive: gameService.chosenDictionary == Flag.unitedKingdom,
                        ),
                      ],
                    ),
                    GameTitle('teamsString'.tr),
                    HorizontalScroll(
                      [
                        createNumberOfTeamsButton(
                          chosenNumberOfTeams: 2,
                          updateValue: () => gameService.updateNumberOfTeams(
                            chosenNumber: 2,
                          ),
                          isActive: gameService.teams.length == 2,
                        ),
                        createNumberOfTeamsButton(
                          chosenNumberOfTeams: 3,
                          updateValue: () => gameService.updateNumberOfTeams(
                            chosenNumber: 3,
                          ),
                          isActive: gameService.teams.length == 3,
                        ),
                        createNumberOfTeamsButton(
                          chosenNumberOfTeams: 4,
                          updateValue: () => gameService.updateNumberOfTeams(
                            chosenNumber: 4,
                          ),
                          isActive: gameService.teams.length == 4,
                        ),
                      ],
                    ),
                    GameTitle('numberOfPointsString'.tr),
                    HorizontalScroll(
                      [
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 25,
                          updateValue: () => gameService.updatePointsToWin = 25,
                          isActive: gameService.pointsToWin == 25,
                        ),
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 50,
                          updateValue: () => gameService.updatePointsToWin = 50,
                          isActive: gameService.pointsToWin == 50,
                        ),
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 75,
                          updateValue: () => gameService.updatePointsToWin = 75,
                          isActive: gameService.pointsToWin == 75,
                        ),
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 100,
                          updateValue: () => gameService.updatePointsToWin = 100,
                          isActive: gameService.pointsToWin == 100,
                        ),
                      ],
                    ),
                    GameTitle('lengthOfRoundString'.tr),
                    HorizontalScroll(
                      [
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 20,
                          updateValue: () => gameService.updateLengthOfRound = 20,
                          isActive: gameService.lengthOfRound == 20,
                        ),
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 45,
                          updateValue: () => gameService.updateLengthOfRound = 45,
                          isActive: gameService.lengthOfRound == 45,
                        ),
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 60,
                          updateValue: () => gameService.updateLengthOfRound = 60,
                          isActive: gameService.lengthOfRound == 60,
                        ),
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 90,
                          updateValue: () => gameService.updateLengthOfRound = 90,
                          isActive: gameService.lengthOfRound == 90,
                        ),
                      ],
                    ),
                    GameTitle('teamNamesString'.tr),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gameService.teams.length,
                      itemBuilder: (context, index) => NameOfTeam(
                        hintText: 'teamNameString'.tr,
                        onChanged: (value) => gameService.teamNameUpdated(
                          index: index,
                          value: value,
                        ),
                      ),
                      shrinkWrap: true,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(16.r),
                    //   child: Container(
                    //     child: !validated
                    //         ? Center(
                    //             child: Text(
                    //               'teamNamesMissingString'.tr,
                    //               style: Theme.of(context).textTheme.bodyText1,
                    //             ),
                    //           )
                    //         : const Text(''),
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment.center,
                      child: PlayButton(
                        text: 'playTheGameString'.tr.toUpperCase(),
                        onPressed: () {},
                        // onPressed: () => setState(validateSetGo),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
