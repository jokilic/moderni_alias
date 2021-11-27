import 'package:flutter/material.dart';

import './components/horizontal_row.dart';
import './components/length_of_round_button.dart';
import './components/name_of_team.dart';
import './components/number_of_points.dart';
import './components/number_of_teams_button.dart';
import '../../components/background_image.dart';
import '../../components/flag_button.dart';
import '../../components/game_title.dart';
import '../../components/play_button.dart';
import '../../models/dictionary.dart';
import '../../strings.dart';
import '../playing_game/playing_game_screen.dart';

Flags chosenDictionary = Flags.croatia;

int numOfTeamsValue = 2;
int pointsToWin = 50;
int lengthOfRound = 60;

late int validationCounter;
bool validated = true;

List<FocusNode> focusNodes = [];
List<TextEditingController> textFieldControllers = [];

List<String> teamNames = [];

Map<String, String> routeArguments = {};

class StartGame extends StatefulWidget {
  static const routeName = '/start-game';

  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  void initState() {
    super.initState();

    focusNodes.clear();
    textFieldControllers.clear();
  }

  @override
  void dispose() {
    super.dispose();

    focusNodes.map((node) => node.dispose()).toList();
    textFieldControllers.map((controller) => controller.dispose()).toList();
  }

// Called when tapping on the 'Rječnik' buttons
  void updateDictionary(Flags chosenFlag) {
    chosenFlag == Flags.croatia
        ? currentDictionary = [...croatianDictionary]
        : currentDictionary = [...englishDictionary];

    setState(() {
      chosenDictionary = chosenFlag;
    });
  }

// Called when tapping on the 'Timovi' buttons
  void updateNumberOfTeams(int chosenValue) {
    focusNodes.clear();
    textFieldControllers.clear();

    setState(() {
      numOfTeamsValue = chosenValue;
    });
  }

// Called when tapping on the 'Broj bodova' buttons
  void updateNumberOfPoints(int chosenValue) {
    setState(() {
      pointsToWin = chosenValue;
    });
  }

// Called when tapping on the 'Duljina runde' buttons
  void updateLengthOfRound(int chosenValue) {
    setState(() {
      lengthOfRound = chosenValue;
    });
  }

// Called when creating TextFields in the dynamic ListView
  NameOfTeam createNameOfTeamTextField(int index) {
    if (focusNodes.length <= index) {
      focusNodes.add(FocusNode());
    }

    if (textFieldControllers.length <= index) {
      textFieldControllers.add(TextEditingController());
    }

    return NameOfTeam(
      hintText: teamNameString,
      focusNode: focusNodes[index],
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNodes[index + 1]),
      textFieldController: textFieldControllers[index],
    );
  }

// Called when tapping on the 'Igraj' button
  void validateSetGo() {
    teamNames.clear();
    textFieldControllers.map((controller) => teamNames.add(controller.text)).toList();

    validateTextFields(textFieldControllers);

    routeArguments = {
      'pointsToWin': pointsToWin.toString(),
      'lengthOfRound': lengthOfRound.toString(),
      'numOfTeams': numOfTeamsValue.toString(),
      'team1': teamNames[0],
      'team2': teamNames[1],
    };

    if (numOfTeamsValue == 3) {
      routeArguments['team3'] = teamNames[2];
    }
    if (numOfTeamsValue == 4) {
      routeArguments['team4'] = teamNames[3];
    }

    if (validated) {
      FocusScope.of(context).unfocus();

      Navigator.pushNamed(
        context,
        PlayingGame.routeName,
        arguments: routeArguments,
      );
    }
  }

// Validate if all TextFields have values
  void validateTextFields(textFieldControllers) {
    validationCounter = 0;
    textFieldControllers.forEach((controller) {
      if (controller.text.isEmpty) {
        validationCounter++;
      }
    });

    focusNodes.clear();
    textFieldControllers.clear();

    validationCounter > 0 ? validated = false : validated = true;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GameTitle(dictionaryString),
                    const HorizontalScroll(
                      [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        createFlagButton(
                          countryName: dictionaryCroatianString,
                          flagImage: croatiaImage,
                          selectedCountry: Flags.croatia,
                          updateValue: () => updateDictionary(Flags.croatia),
                        ),
                        createFlagButton(
                          countryName: dictionaryEnglishString,
                          flagImage: unitedKingdomImage,
                          selectedCountry: Flags.unitedKingdom,
                          updateValue: () => updateDictionary(Flags.unitedKingdom),
                        ),
                      ],
                    ),
                    const GameTitle(teamsString),
                    HorizontalScroll(
                      [
                        createNumberOfTeamsButton(
                          chosenNumberOfTeams: 2,
                          updateValue: () => updateNumberOfTeams(2),
                        ),
                        createNumberOfTeamsButton(
                          chosenNumberOfTeams: 3,
                          updateValue: () => updateNumberOfTeams(3),
                        ),
                        createNumberOfTeamsButton(
                          chosenNumberOfTeams: 4,
                          updateValue: () => updateNumberOfTeams(4),
                        ),
                      ],
                    ),
                    const GameTitle(numberOfPointsString),
                    HorizontalScroll(
                      [
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 25,
                          updateValue: () => updateNumberOfPoints(25),
                        ),
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 50,
                          updateValue: () => updateNumberOfPoints(50),
                        ),
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 75,
                          updateValue: () => updateNumberOfPoints(75),
                        ),
                        createNumberOfPointsButton(
                          chosenNumberOfPoints: 100,
                          updateValue: () => updateNumberOfPoints(100),
                        ),
                      ],
                    ),
                    const GameTitle(lengthOfRoundString),
                    HorizontalScroll(
                      [
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 20,
                          updateValue: () => updateLengthOfRound(20),
                        ),
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 45,
                          updateValue: () => updateLengthOfRound(45),
                        ),
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 60,
                          updateValue: () => updateLengthOfRound(60),
                        ),
                        createLengthOfRoundButton(
                          chosenLengthOfRound: 90,
                          updateValue: () => updateLengthOfRound(90),
                        ),
                      ],
                    ),
                    const GameTitle(teamNamesString),
                    ListView.builder(
                      itemCount: numOfTeamsValue,
                      itemBuilder: (context, index) => createNameOfTeamTextField(index),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        child: !validated
                            ? Center(
                                child: Text(
                                  teamNamesMissingString,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              )
                            : const Text(''),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: PlayButton(
                        text: playTheGameString.toUpperCase(),
                        onPressed: () => setState(validateSetGo),
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
