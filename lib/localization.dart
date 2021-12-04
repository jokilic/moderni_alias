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

  /// TODO: Implement proper english language
  final en = {
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
    'whoEighthString':
        ' jer sam htio vježbati izradu aplikacija, naučiti neke nove koncepte i ideje.\nTakođer sam htio iznenaditi prijatelje koji vole igrati Alias.',

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

    'wordWrongExplanationFirstString':
        'Ako tim pogađa trenutnu riječ, a jasno je da ju neće pogoditi, onaj koji objašnjava odabire tipku sa ',
    'wordWrongExplanationSecondString': 'iksićem',
    'wordWrongExplanationThirdString': '. Tim je dobio jedan bod manje i pogađa sljedeću riječ.',

    'roundFinishedExplanationString':
        'Runda je završila i sad je vrijeme za drugi tim.\nJedan od članova drugog tima objašnjava riječi dok drugi članovi pogađaju.\n\nTimovi se izmjenjuju dok jedan od njih ne skupi dovoljan broj bodova za pobjedu.',

    'howToQuickAliasExplanationFirstString': 'Brzi Alias se igra bez timova, bez dodatnih pravila. Igra traje ',
    'howToQuickAliasExplanationSecondString': '60 sekundi',
    'howToQuickAliasExplanationThirdString':
        ' i odmah počinje.\nKada vrijeme završi, vidljivi su točni i krivi odgovori.\n\nAko želite, moguće je odigrati novu igru ili se vratiti u glavni meni.',
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
    'whoSixthString':
        'Volim izrađivati mobilne aplikacije i volim development općenito.\nOdlučio sam napraviti Moderni Alias jer sam htio vježbati izradu aplikacija, naučiti neke nove koncepte i ideje.\nTakođer sam htio iznenaditi prijatelje koji vole igrati Alias.',

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

    'wordWrongExplanationFirstString':
        'Ako tim pogađa trenutnu riječ, a jasno je da ju neće pogoditi, onaj koji objašnjava odabire tipku sa ',
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
