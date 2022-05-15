import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'hr': hr,
      };

  final en = {
    /// Home Page
    'appNameString': 'ModerniAlias',
    'appNameFirstString': 'Moderni',
    'appNameSecondString': 'Alias',

    'startButtonString': 'Normal game',
    'quickStartButtonString': 'Quick game',
    'statsButtonString': 'Stats',
    'howToPlayButtonString': 'How to play Alias?',

    /// Start Game
    'dictionaryString': 'Dictionary',
    'dictionaryCroatianString': 'Croatian',
    'dictionaryEnglishString': 'English',
    'teamsString': 'Teams',
    'numberOfPointsString': 'Number of points',
    'lengthOfRoundString': 'Length of round',
    'teamNamesString': 'Names of teams',
    'teamNameString': 'Name of team',
    'teamNamesMissingString': "You're missing the names of teams...",
    'teamNamesSameString': 'The team names are the same...',
    'playTheGameString': 'Play',

    /// Playing Game
    'currentlyPlayingTitle': 'Currently playing',
    'exitModalQuestionString': 'Do you want to quit the current game?',
    'exitModalQuestionYes': 'Yes',
    'exitModalQuestionNo': 'No',
    'scoresModalString': 'Current scores',
    'startGameOnPressString': 'Tap here and start game',

    /// Game Finished
    'winnerFirstString': 'The winner is ',
    'winnerSecondString': ' with ',
    'winnerThirdString': ' points!',

    /// Quick Game
    'quickGameFinishedFirstString': 'You had ',
    'quickGameFinishedSecondString': ' correct and ',
    'quickGameFinishedThirdString': ' wrong answers.',
    'quickGameFinishedPlayAgainString': 'Play again',
    'quickGameFinishedExitString': 'Quit',

    /// General Info
    'howTitleString': 'How?',
    'howFirstString': 'I used ',
    'howSecondString': 'Flutter',
    'howThirdString': ' to develop Moderni Alias.\n\n',
    'howFourthString':
        "Flutter is a UI development kit created by Google. It's used to build beautiful apps for mobile devices, web and desktop. If you want to know more or would love to create some interesting app, start with ",
    'howFifthString': "Flutter's official site",
    'howSixthString': '.\n\n',
    'howSeventhString': 'Moderni Alias is completely open source, you can see the code on ',
    'howEightString': 'GitHub',
    'howNinthString': '.',

    'whoTitleString': 'Who?',
    'whoFirstString': 'My name is ',
    'whoSecondString': 'Josip',
    'whoThirdString': ' and I come from ',
    'whoFourthString': 'Croatia',
    'whoFifthString': '.\n\n',
    'whoSixthString': "I love developing mobile apps and I love development in general.\n\nI've decided to create ",
    'whoSeventhString': 'Moderni Alias',
    'whoEighthString': " because I wanted to practice my app developing skills, learn new concepts and ideas.\nI've also wanted to surprise my friends who love to play Alias.",

    'aboutMeTitleString': 'More about me',
    'aboutMeWebsiteString': 'josipkilic.com',
    'aboutMeGitHubString': 'GitHub',
    'aboutMeEmailString': 'E-Mail',

    'fontTitleString': 'Font?',
    'fontFirstString': "Font I'm using is called ",
    'fontSecondString': 'Sen',
    'fontThirdString': '.\n',
    'fontFourthString': "It's designed by ",
    'fontFifthString': 'Kosal Sen',
    'fontSixthString': ', you can find it on ',
    'fontSeventhString': 'Google Fonts',
    'fontEigthString': '.',

    'iconsTitleString': 'Icons?',
    'iconsFirstString': "I'm using multiple icons in Moderni Alias:",

    'appIconTitleString': 'Moderni Alias icon',
    'appIconFirstString': 'I found the icon on ',
    'appIconSecondString': 'Flaticon',
    'appIconThirdString': '.\nI was searching for ',
    'appIconFourthString': 'conversation',
    'appIconFifthString': " and I thought this one looked the best.\nChanged the colors a little bit and that's it.",

    'otherIconsTitleString': 'Other icons',
    'otherIconsFirstString': 'Found them all on ',
    'otherIconsSecondString': 'Flaticon',
    'otherIconsThirdString': ".\nDone some minimal changes on some and that's it.",

    'soundsTitleString': 'Sounds?',

    'wrongCorrectSoundsTitleString': 'Correct/Wrong',
    'wrongCorrectSoundsFirstString': 'I found the sounds on the ',
    'wrongCorrectSoundsSecondString': 'Google Sounds',
    'wrongCorrectSoundsThirdString': " app.\nThey're called ",
    'wrongCorrectSoundsFourthString': 'Bud',
    'wrongCorrectSoundsFifthString': ' and ',
    'wrongCorrectSoundsSixthString': 'Pollen',
    'wrongCorrectSoundsSeventhString': '.',

    'countdownSoundsTitleString': 'Countdown sounds',
    'countdownSoundsFirstString': 'I found the countdown sounds on ',
    'countdownSoundsSecondString': 'Freesound',
    'countdownSoundsThirdString': '.\nI downloaded two sounds, cut them a bit, connected them together and got this sound.',

    'screenshotsTitleString': 'Screenshots?',
    'screenshotsFirstString': "Screenshots you're seeing on ",
    'screenshotsSecondString': 'Play Store',
    'screenshotsThirdString': ' and ',
    'screenshotsFourthString': 'GitHub',
    'screenshotsFifthString': ' are created with ',
    'screenshotsSixthString': 'previewed.app',
    'screenshotsSeventhString': '.',

    /// How to Play
    'whatIsAliasTitleString': 'What is Alias?',
    'howToPlayTitleString': 'How to play Alias?',
    'wordCorrectTitleString': 'You guessed the word',
    'wordWrongTitleString': "You don't know the word",
    'roundFinishedTitleString': 'Round is over',
    'howToQuickAliasTitleString': 'Quick Alias?',
    'enjoyTitleString': 'Enjoy this fun game.',

    'whatIsAliasFirstString': 'Alias',
    'whatIsAliasSecondString': ' is a fun explaining game which is played by ',
    'whatIsAliasThirdString': 'two or more teams of players',
    'whatIsAliasFourthString': '. The players explain terms using words of a similar or opposite meaning, associations or similar, so the members of your team guess ',
    'whatIsAliasFifthString': 'many terms before time runs out',
    'whatIsAliasSixthString': '.',

    'howToPlayExplanationString':
        "Let's say you're playing Alias in three teams. Each team has four players.\n\nGame gets started by the first team. One of the members explains the words while others guess.",

    'wordCorrectExplanationFirstString': 'If the word is guessed, the explaining person taps the button with the ',
    'wordCorrectExplanationSecondString': 'checkmark',
    'wordCorrectExplanationThirdString': '. Team has won a point and guesses the next word.',

    'wordWrongExplanationFirstString': "If the team is guessing the current word and it's clear they are not going to guess it, the one explaining taps the button with an ",
    'wordWrongExplanationSecondString': 'X icon',
    'wordWrongExplanationThirdString': '. Team has lost a point and guesses the next word.',

    'roundFinishedExplanationString':
        "Round has finished and now it's time for the other team.\nOne of the members of the other team explains the words while other team members guess.\n\nTeams are changing while one of them has enough points to win.",

    'howToQuickAliasExplanationFirstString': 'Quick Alias is played without teams, without additional rules. Length of the game is ',
    'howToQuickAliasExplanationSecondString': '60 seconds',
    'howToQuickAliasExplanationThirdString':
        ' and starts right away.\nWhen the time is finished, you can see the correct and wrong answers.\n\nIf you want, you can play a new game or return to the main menu.',
  };

  final hr = {
    /// Home Page
    'appNameString': 'ModerniAlias',
    'appNameFirstString': 'Moderni',
    'appNameSecondString': 'Alias',

    'startButtonString': 'Normalna igra',
    'quickStartButtonString': 'Brza igra',
    'howToPlayButtonString': 'Kako igrati Alias?',

    /// Start Game
    'dictionaryString': 'Rječnik',
    'dictionaryCroatianString': 'Hrvatski',
    'dictionaryEnglishString': 'Engleski',
    'teamsString': 'Timovi',
    'numberOfPointsString': 'Broj bodova',
    'lengthOfRoundString': 'Duljina runde',
    'teamNamesString': 'Imena timova',
    'teamNameString': 'Ime tima',
    'teamNamesMissingString': 'Imena timova ti fale...',
    'teamNamesSameString': 'Imena timova su ista...',
    'playTheGameString': 'Igraj',

    /// Playing Game
    'currentlyPlayingTitle': 'Trenutno igra',
    'exitModalQuestionString': 'Želiš li izaći iz trenutne igre?',
    'exitModalQuestionYes': 'Da',
    'exitModalQuestionNo': 'Ne',
    'scoresModalString': 'Trenutni rezultati',
    'startGameOnPressString': 'Stisni ovdje i počni igru',

    /// Game Finished
    'winnerFirstString': 'Pobjednik je ',
    'winnerSecondString': ' sa ',
    'winnerThirdString': ' bodova!',

    /// Quick Game
    'quickGameFinishedFirstString': 'Imali ste ',
    'quickGameFinishedSecondString': ' točnih i ',
    'quickGameFinishedThirdString': ' krivih odgovora.',
    'quickGameFinishedPlayAgainString': 'Igraj ponovno',
    'quickGameFinishedExitString': 'Izađi',

    /// General Info
    'howTitleString': 'Kako?',
    'howFirstString': 'Koristio sam ',
    'howSecondString': 'Flutter',
    'howThirdString': ' za izradu Modernog Aliasa.\n\n',
    'howFourthString':
        'Flutter je Googleov UI alat za izradu prekrasnih aplikacija za mobilne uređaje, web i desktop. Ako vas zanima više i želite napraviti nekakvu zanimljivu aplikaciju, počnite od ',
    'howFifthString': 'Flutterove službene stranice',
    'howSixthString': '.\n\n',
    'howSeventhString': 'Moderni Alias je potpuno open-source, a kod možete vidjeti na ',
    'howEightString': 'GitHubu',
    'howNinthString': '.',

    'whoTitleString': 'Tko?',
    'whoFirstString': 'Zovem se ',
    'whoSecondString': 'Josip',
    'whoThirdString': ' i dolazim iz ',
    'whoFourthString': 'Hrvatske',
    'whoFifthString': '.\n\n',
    'whoSixthString': 'Volim izrađivati mobilne aplikacije i volim development općenito.\n\nOdlučio sam napraviti ',
    'whoSeventhString': 'Moderni Alias',
    'whoEighthString': ' jer sam htio vježbati izradu aplikacija, naučiti neke nove koncepte i ideje.\nTakođer sam htio iznenaditi prijatelje koji vole igrati Alias.',

    'aboutMeTitleString': 'Više o meni',
    'aboutMeWebsiteString': 'josipkilic.com',
    'aboutMeGitHubString': 'GitHub',
    'aboutMeEmailString': 'E-Mail',

    'fontTitleString': 'Font?',
    'fontFirstString': 'Font koji koristim se zove ',
    'fontSecondString': 'Sen',
    'fontThirdString': '.\n',
    'fontFourthString': 'Dizajnirao ga je ',
    'fontFifthString': 'Kosal Sen',
    'fontSixthString': ', možete ga naći na ',
    'fontSeventhString': 'Google Fonts',
    'fontEigthString': '.',

    'iconsTitleString': 'Ikone?',
    'iconsFirstString': 'Koristim više ikona u Modernom Aliasu:',

    'appIconTitleString': 'Ikona Modernog Aliasa',
    'appIconFirstString': 'Našao sam ikonu na ',
    'appIconSecondString': 'Flaticon',
    'appIconThirdString': '.\nTražio sam ',
    'appIconFourthString': 'conversation',
    'appIconFifthString': ' i ova je izgledala najbolje, po mom mišljenju.\nMalo sam promijenio boje i to je to.',

    'otherIconsTitleString': 'Ostale ikone',
    'otherIconsFirstString': 'Sve sam ih našao na ',
    'otherIconsSecondString': 'Flaticon',
    'otherIconsThirdString': '.\nNeke sam minimalno promijenio i to je sve.',

    'soundsTitleString': 'Zvukovi?',

    'wrongCorrectSoundsTitleString': 'Točno/Netočno',
    'wrongCorrectSoundsFirstString': 'Zvukove sam našao na ',
    'wrongCorrectSoundsSecondString': 'Google Sounds',
    'wrongCorrectSoundsThirdString': ' aplikaciji.\nZovu se ',
    'wrongCorrectSoundsFourthString': 'Bud',
    'wrongCorrectSoundsFifthString': ' i ',
    'wrongCorrectSoundsSixthString': 'Pollen',
    'wrongCorrectSoundsSeventhString': '.',

    'countdownSoundsTitleString': 'Zvukovi odbrojavanja',
    'countdownSoundsFirstString': 'Zvukove odbrojavanja sam našao na ',
    'countdownSoundsSecondString': 'Freesound',
    'countdownSoundsThirdString': '.\nSkinuo sam dva zvuka, skratio ih i spojio te dobio ovaj zvuk.',

    'screenshotsTitleString': 'Screenshotovi?',
    'screenshotsFirstString': 'Screenshotove koje vidite na ',
    'screenshotsSecondString': 'Play Storeu',
    'screenshotsThirdString': ' i ',
    'screenshotsFourthString': 'GitHubu',
    'screenshotsFifthString': ' sam napravio sa ',
    'screenshotsSixthString': 'previewed.app',
    'screenshotsSeventhString': '.',

    /// How to Play
    'whatIsAliasTitleString': 'Što je Alias?',
    'howToPlayTitleString': 'Kako igrati Alias?',
    'wordCorrectTitleString': 'Pogodili ste riječ',
    'wordWrongTitleString': 'Ne znate riječ',
    'roundFinishedTitleString': 'Runda je gotova',
    'howToQuickAliasTitleString': 'Brzi Alias?',
    'enjoyTitleString': 'Uživajte u ovoj zabavnoj igri.',

    'whatIsAliasFirstString': 'Alias',
    'whatIsAliasSecondString': ' je zabavna igra objašnjavanja pojmova koju igraju ',
    'whatIsAliasThirdString': 'dva ili više tima igrača',
    'whatIsAliasFourthString':
        '. U igri se objašnjavaju pojmovi upotrebljavajući riječi srodnog ili suprotnog značenja, asocijacije i slično, tako da pripadnici vaše ekipe pogode ',
    'whatIsAliasFifthString': 'što više pojmova prije isteka vremena',
    'whatIsAliasSixthString': '.',

    'howToPlayExplanationString':
        'Recimo da Alias igrate u tri tima. Svaki tim ima po četiri igrača.\n\nIgru počinje prvi tim. Jedan od članova tima objašnjava riječi dok drugi članovi pogađaju.',

    'wordCorrectExplanationFirstString': 'Ako je riječ pogođena, onaj koji objašnjava odabire tipku sa ',
    'wordCorrectExplanationSecondString': 'kvačicom',
    'wordCorrectExplanationThirdString': '. Tim je dobio bod i pogađa sljedeću riječ.',

    'wordWrongExplanationFirstString': 'Ako tim pogađa trenutnu riječ, a jasno je da ju neće pogoditi, onaj koji objašnjava odabire tipku sa ',
    'wordWrongExplanationSecondString': 'iksićem',
    'wordWrongExplanationThirdString': '. Tim je dobio jedan bod manje i pogađa sljedeću riječ.',

    'roundFinishedExplanationString':
        'Runda je završila i sad je vrijeme za drugi tim.\nJedan od članova drugog tima objašnjava riječi dok drugi članovi pogađaju.\n\nTimovi se izmjenjuju dok jedan od njih ne skupi dovoljan broj bodova za pobjedu.',

    'howToQuickAliasExplanationFirstString': 'Brzi Alias se igra bez timova, bez dodatnih pravila. Igra traje ',
    'howToQuickAliasExplanationSecondString': '60 sekundi',
    'howToQuickAliasExplanationThirdString':
        ' i odmah počinje.\nKada vrijeme završi, vidljivi su točni i krivi odgovori.\n\nAko želite, moguće je odigrati novu igru ili se vratiti u glavni meni.',
  };
}
