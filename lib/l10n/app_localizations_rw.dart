// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kinyarwanda (`rw`).
class AppLocalizationsRw extends AppLocalizations {
  AppLocalizationsRw([String locale = 'rw']) : super(locale);

  @override
  String get appName => 'Amabaruwa';

  @override
  String get appTagline => 'Inzira ya Kristu';

  @override
  String get navHome => 'Ahabanza';

  @override
  String get navLetters => 'Amabaruwa';

  @override
  String get navDownloads => 'Ibikururwa';

  @override
  String get settings => 'Igenamiterere';

  @override
  String get settingsTitle => 'Igenamiterere';

  @override
  String get retry => 'Ongera ugerageze';

  @override
  String get cancel => 'Hagarika';

  @override
  String get delete => 'Siba';

  @override
  String get close => 'Funga';

  @override
  String get back => 'Subira inyuma';

  @override
  String get search => 'Shakisha';

  @override
  String get searchHint => 'Shakisha ku izina cyangwa nimero';

  @override
  String get filterAll => 'Zose';

  @override
  String get filterFavorites => 'Ibikunzwe';

  @override
  String get filterAudio => 'Bifite amajwi';

  @override
  String get filterOffline => 'Bihari nta murandasi';

  @override
  String get noResults => 'Nta baruwa ihuye n’ishakisha.';

  @override
  String get lettersTitle => 'Amabaruwa';

  @override
  String letterCount(Object count) {
    return '$count zose';
  }

  @override
  String get lettersEmpty => 'Nta baruwa zirabona. Huza interineti ugerageze.';

  @override
  String get homeTitle => 'Ahabanza';

  @override
  String get dailyWordTitle => 'Ijambo ry’uyu munsi';

  @override
  String get dailyWordToday => 'Ijambo ry’uyu munsi';

  @override
  String get dailyWordFallback => 'Ijambo rya nyuma ryabitswe';

  @override
  String get dailyWordNone => 'Nta jambo ryabitswe kuri telefoni.';

  @override
  String get dailyWordDemo => 'Urugero gusa';

  @override
  String get share => 'Sangiza';

  @override
  String get listen => 'Umva';

  @override
  String get readMore => 'Soma byose';

  @override
  String get continueReading => 'Komeza usome';

  @override
  String get continueListening => 'Komeza wumve';

  @override
  String get library => 'Isomero';

  @override
  String get openLibrary => 'Fungura isomero';

  @override
  String letterNumber(Object number) {
    return 'Ibaruwa ya $number';
  }

  @override
  String readingProgress(Object percent) {
    return 'Wageze kuri $percent %';
  }

  @override
  String get downloadPdf => 'Kurura PDF';

  @override
  String get downloadAudio => 'Kurura amajwi';

  @override
  String get downloadPack => 'Kurura byose';

  @override
  String get downloaded => 'Byakurujwe';

  @override
  String get notDownloaded => 'Ntibirakururwa';

  @override
  String get downloading => 'Biracyakururwa';

  @override
  String get downloadPaused => 'Byahagaritswe';

  @override
  String get downloadFailed => 'Byanze';

  @override
  String get downloadCompleted => 'Byarangiye';

  @override
  String get downloadPending => 'Bitegereje';

  @override
  String get downloadRetry => 'Ongera';

  @override
  String get downloadCancel => 'Hagarika';

  @override
  String get downloadDelete => 'Siba dosiye';

  @override
  String get downloadsTitle => 'Ibikururwa';

  @override
  String get downloadsEmpty => 'Nta dosiye zirakururwa.';

  @override
  String get downloadsEmptyHint =>
      'Fungura ibaruwa ukurure PDF cyangwa amajwi.';

  @override
  String get storageUsed => 'Ahari mu telefoni';

  @override
  String storageSummary(Object used) {
    return '$used byakoreshejwe';
  }

  @override
  String get storageUnavailable => 'Ingano y’ububiko ntiboneka';

  @override
  String get insufficientSpace => 'Ububiko ntibuhagije kuri iyi dosiye.';

  @override
  String get offlineMessage => 'Nta murandasi. Amakuru yabitswe arakoreshwa.';

  @override
  String get onlineMessage => 'Umeruje kuri interineti.';

  @override
  String get syncError => 'Guhuza amakuru byanze.';

  @override
  String get syncSuccess => 'Amakuru yahujwe.';

  @override
  String get syncNow => 'Huza nonaha';

  @override
  String get lastSync => 'Guhuza kwa nyuma';

  @override
  String get neverSynced => 'Ntibyigeze bihuzwa';

  @override
  String get firstLaunchOffline =>
      'Nta murandasi, kandi nta makuru yabitswe kuri telefoni. Huza interineti ugerageze.';

  @override
  String get errorLoading => 'Hari ikibazo mu gupakira amakuru.';

  @override
  String get emptyLetters => 'Nta baruwa zirabona.';

  @override
  String get source => 'Inkomoko';

  @override
  String get attribution => 'Inkomoko: inzirayakristu.com';

  @override
  String get licenses => 'Uruhushya n’inkomoko';

  @override
  String get fontSize => 'Ingano y’inyandiko';

  @override
  String get decreaseFont => 'Gabanura inyandiko';

  @override
  String get increaseFont => 'Ongera inyandiko';

  @override
  String get theme => 'Uburyo bw’amabara';

  @override
  String get themeSystem => 'Uburyo bwa sisitemu';

  @override
  String get themeLight => 'Uburyo bwera';

  @override
  String get themeDark => 'Uburyo bwijimye';

  @override
  String get about => 'Ibyerekeye';

  @override
  String version(Object version) {
    return 'Verisiyo $version';
  }

  @override
  String get speed => 'Umuvuduko';

  @override
  String get sleepTimer => 'Guhagarika amajwi';

  @override
  String get sleepOff => 'Ntibihagarara';

  @override
  String get minutes15 => 'Iminota 15';

  @override
  String get minutes30 => 'Iminota 30';

  @override
  String get minutes60 => 'Iminota 60';

  @override
  String get skipBack15 => 'Subiza amasegonda 15';

  @override
  String get skipForward15 => 'Jugunya amasegonda 15';

  @override
  String get play => 'Tangiza';

  @override
  String get pause => 'Hagarika';

  @override
  String get miniPlayer => 'Umva amajwi';

  @override
  String get readingSettings => 'Igenamiterere ry’ugusoma';

  @override
  String get pdfTitle => 'PDF y’ibaruwa';

  @override
  String get audioTitle => 'Amajwi y’ibaruwa';

  @override
  String get audioShort => 'Amajwi';

  @override
  String get fontPreview => 'Urugero rw’inyandiko y’ibaruwa.';

  @override
  String get sleepActive => 'Guhagarika amajwi bikora';

  @override
  String get nowPlaying => 'Birakina';

  @override
  String get unavailableOnServer => 'Ntiboneka kuri seriveri';

  @override
  String get noAudio => 'Nta majwi abonetse kuri iyi baruwa.';

  @override
  String get noPdf => 'Nta PDF ibonetse kuri iyi baruwa.';

  @override
  String get favoriteAdded => 'Yongewe mu bikunzwe.';

  @override
  String get favoriteRemoved => 'Yakuwe mu bikunzwe.';

  @override
  String get deleteConfirmTitle => 'Siba dosiye ?';

  @override
  String get deleteConfirmBody =>
      'Dosiye izasibwa, ariko inyandiko y’ibaruwa izaguma.';

  @override
  String get downloadUnavailable => 'Gukurura ntibishoboka ubu.';

  @override
  String get invalidFile =>
      'Dosiye ntuzuye cyangwa yononekare. Ongera ugerageze.';

  @override
  String get interruptedDownload => 'Gukurura byahagaritswe. Ongera ugerageze.';

  @override
  String get resume => 'Komeza';

  @override
  String lastRead(Object date) {
    return 'Wasomye $date';
  }

  @override
  String updatedAt(Object date) {
    return 'Byavuguruwe $date';
  }

  @override
  String get languageName => 'Ikinyarwanda';

  @override
  String get letterNotFound => 'Iyi baruwa ntabonetse.';

  @override
  String get loading => 'Birakora…';

  @override
  String get menu => 'Ibikubiyemo';

  @override
  String get menuIntro =>
      'Amakuru ajyanye n’inkomoko y’aya mabaruwa n’itsinda riyitaho.';

  @override
  String get menuNyirikwandikaDescription => 'Inkomoko y’amabaruwa.';

  @override
  String get menuBeneBudamaDescription => 'Itsinda riyahinduye mu Kinyarwanda.';

  @override
  String get menuKudutumahoDescription =>
      'Twandikire cyangwa utange igitekerezo.';

  @override
  String get contactUs => 'Twandikire';

  @override
  String get sourcePage => 'Reba ipaji y’inkomoko';

  @override
  String get openPdf => 'Fungura PDF';

  @override
  String get openAudio => 'Fungura amajwi';

  @override
  String get downloadInProgress => 'Biracyakururwa…';

  @override
  String get readText => 'Soma inyandiko';

  @override
  String get audioUnavailableOffline =>
      'Amajwi ntaboneka nta murandasi. Kurura mbere.';

  @override
  String get pdfUnavailableOffline =>
      'PDF ntaboneka nta murandasi. Kurura mbere.';

  @override
  String get dataSync => 'Guhuza amakuru';

  @override
  String get clearDownloads => 'Siba ibyakurujwe';

  @override
  String get clearDownloadsBody =>
      'Dosiye zose zikurujwe zizasibwa, inyandiko zo mu mabaruwa zizaguma.';

  @override
  String get clear => 'Siba byose';

  @override
  String get onboardingSkip => 'Komeza';

  @override
  String get today => 'Uyu munsi';

  @override
  String get older => 'Byabitswe';

  @override
  String get downloadSpaceCheck => 'Kugenzura ububiko…';

  @override
  String get fileVerified => 'Dosiye yagenzuwe';

  @override
  String get fileInvalid => 'Dosiye ntiyagenzuwe';

  @override
  String get noInternet => 'Nta murandasi';

  @override
  String get connected => 'Umeruje';

  @override
  String get notConnected => 'Ntabwo umeruje';

  @override
  String get syncOffline => 'Ntibishoboka guhuza nta murandasi.';

  @override
  String get sourceLink => 'Reba inkomoko';

  @override
  String shareText(Object title) {
    return '$title — Inkomoko: inzirayakristu.com';
  }
}
