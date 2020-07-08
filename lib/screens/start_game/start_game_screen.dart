import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../components/background_image.dart';
import '../../components/play_button.dart';
import '../../components/game_title.dart';
import './components/horizontal_row.dart';
import './components/number_of_teams_button.dart';
import './components/number_of_points.dart';
import './components/length_of_round_button.dart';
import './components/name_of_team.dart';
import '../playing_game/playing_game_screen.dart';

int numOfTeamsValue = 2;
int pointsToWin = 50;
int lengthOfRound = 60;

int validationCounter;
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

    focusNodes.forEach(
      (node) => node.dispose(),
    );

    textFieldControllers.forEach(
      (controller) => controller.dispose(),
    );
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
    if (focusNodes.length <= index) focusNodes.add(FocusNode());

    if (textFieldControllers.length <= index)
      textFieldControllers.add(TextEditingController());

    return NameOfTeam(
      hintText: teamNameString,
      focusNode: focusNodes[index],
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(focusNodes[index + 1]),
      textFieldController: textFieldControllers[index],
    );
  }

// Called when tapping on the 'Igraj' button
  void validateSetGo() {
    teamNames.clear();
    textFieldControllers.forEach((controller) {
      teamNames.add(controller.text);
    });

    validateTextFields(textFieldControllers);

    routeArguments = {
      'pointsToWin': pointsToWin.toString(),
      'lengthOfRound': lengthOfRound.toString(),
      'numOfTeams': numOfTeamsValue.toString(),
      'team1': teamNames[0],
      'team2': teamNames[1],
    };

    if (numOfTeamsValue == 3) routeArguments['team3'] = teamNames[2];
    if (numOfTeamsValue == 4) routeArguments['team4'] = teamNames[3];

    if (validated) {
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
      if (controller.text.isEmpty) validationCounter++;
    });

    focusNodes.clear();
    textFieldControllers.clear();

    validationCounter > 0 ? validated = false : validated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GameTitle(teamsString),
                  HorizontalScroll(
                    [
                      createNumberOfTeamsButton(
                        2,
                        () => updateNumberOfTeams(2),
                      ),
                      createNumberOfTeamsButton(
                        3,
                        () => updateNumberOfTeams(3),
                      ),
                      createNumberOfTeamsButton(
                        4,
                        () => updateNumberOfTeams(4),
                      ),
                    ],
                  ),
                  GameTitle(numberOfPointsString),
                  HorizontalScroll(
                    [
                      createNumberOfPointsButton(
                        25,
                        () => updateNumberOfPoints(25),
                      ),
                      createNumberOfPointsButton(
                        50,
                        () => updateNumberOfPoints(50),
                      ),
                      createNumberOfPointsButton(
                        75,
                        () => updateNumberOfPoints(75),
                      ),
                      createNumberOfPointsButton(
                        100,
                        () => updateNumberOfPoints(100),
                      ),
                    ],
                  ),
                  GameTitle(lengthOfRoundString),
                  HorizontalScroll(
                    [
                      createLengthOfRoundButton(
                        20,
                        () => updateLengthOfRound(20),
                      ),
                      createLengthOfRoundButton(
                        45,
                        () => updateLengthOfRound(45),
                      ),
                      createLengthOfRoundButton(
                        60,
                        () => updateLengthOfRound(60),
                      ),
                      createLengthOfRoundButton(
                        90,
                        () => updateLengthOfRound(90),
                      ),
                    ],
                  ),
                  GameTitle(teamNamesString),
                  ListView.builder(
                    itemCount: numOfTeamsValue,
                    itemBuilder: (context, index) =>
                        createNameOfTeamTextField(index),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: !validated
                          ? Center(
                              child: Text(
                                teamNamesMissingString,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )
                          : Text(''),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: PlayButton(
                      text: playTheGameString.toUpperCase(),
                      horizontalPadding: 50.0,
                      onPressed: () {
                        setState(
                          () {
                            validateSetGo();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
