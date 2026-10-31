import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_rw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('rw')];

  /// No description provided for @appName.
  ///
  /// In rw, this message translates to:
  /// **'Amabaruwa'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In rw, this message translates to:
  /// **'Inzira ya Kristu'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In rw, this message translates to:
  /// **'Ahabanza'**
  String get navHome;

  /// No description provided for @navLetters.
  ///
  /// In rw, this message translates to:
  /// **'Amabaruwa'**
  String get navLetters;

  /// No description provided for @navDownloads.
  ///
  /// In rw, this message translates to:
  /// **'Ibikururwa'**
  String get navDownloads;

  /// No description provided for @settings.
  ///
  /// In rw, this message translates to:
  /// **'Igenamiterere'**
  String get settings;

  /// No description provided for @settingsTitle.
  ///
  /// In rw, this message translates to:
  /// **'Igenamiterere'**
  String get settingsTitle;

  /// No description provided for @retry.
  ///
  /// In rw, this message translates to:
  /// **'Ongera ugerageze'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In rw, this message translates to:
  /// **'Hagarika'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In rw, this message translates to:
  /// **'Siba'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In rw, this message translates to:
  /// **'Funga'**
  String get close;

  /// No description provided for @back.
  ///
  /// In rw, this message translates to:
  /// **'Subira inyuma'**
  String get back;

  /// No description provided for @search.
  ///
  /// In rw, this message translates to:
  /// **'Shakisha'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In rw, this message translates to:
  /// **'Shakisha ku izina cyangwa nimero'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In rw, this message translates to:
  /// **'Zose'**
  String get filterAll;

  /// No description provided for @filterFavorites.
  ///
  /// In rw, this message translates to:
  /// **'Ibikunzwe'**
  String get filterFavorites;

  /// No description provided for @filterAudio.
  ///
  /// In rw, this message translates to:
  /// **'Bifite amajwi'**
  String get filterAudio;

  /// No description provided for @filterOffline.
  ///
  /// In rw, this message translates to:
  /// **'Bihari nta murandasi'**
  String get filterOffline;

  /// No description provided for @noResults.
  ///
  /// In rw, this message translates to:
  /// **'Nta baruwa ihuye n’ishakisha.'**
  String get noResults;

  /// No description provided for @lettersTitle.
  ///
  /// In rw, this message translates to:
  /// **'Amabaruwa'**
  String get lettersTitle;

  /// No description provided for @letterCount.
  ///
  /// In rw, this message translates to:
  /// **'{count} zose'**
  String letterCount(Object count);

  /// No description provided for @lettersEmpty.
  ///
  /// In rw, this message translates to:
  /// **'Nta baruwa zirabona. Huza interineti ugerageze.'**
  String get lettersEmpty;

  /// No description provided for @homeTitle.
  ///
  /// In rw, this message translates to:
  /// **'Ahabanza'**
  String get homeTitle;

  /// No description provided for @dailyWordTitle.
  ///
  /// In rw, this message translates to:
  /// **'Ijambo ry’uyu munsi'**
  String get dailyWordTitle;

  /// No description provided for @dailyWordToday.
  ///
  /// In rw, this message translates to:
  /// **'Ijambo ry’uyu munsi'**
  String get dailyWordToday;

  /// No description provided for @dailyWordFallback.
  ///
  /// In rw, this message translates to:
  /// **'Ijambo rya nyuma ryabitswe'**
  String get dailyWordFallback;

  /// No description provided for @dailyWordNone.
  ///
  /// In rw, this message translates to:
  /// **'Nta jambo ryabitswe kuri telefoni.'**
  String get dailyWordNone;

  /// No description provided for @dailyWordDemo.
  ///
  /// In rw, this message translates to:
  /// **'Urugero gusa'**
  String get dailyWordDemo;

  /// No description provided for @share.
  ///
  /// In rw, this message translates to:
  /// **'Sangiza'**
  String get share;

  /// No description provided for @listen.
  ///
  /// In rw, this message translates to:
  /// **'Umva'**
  String get listen;

  /// No description provided for @readMore.
  ///
  /// In rw, this message translates to:
  /// **'Soma byose'**
  String get readMore;

  /// No description provided for @continueReading.
  ///
  /// In rw, this message translates to:
  /// **'Komeza usome'**
  String get continueReading;

  /// No description provided for @continueListening.
  ///
  /// In rw, this message translates to:
  /// **'Komeza wumve'**
  String get continueListening;

  /// No description provided for @library.
  ///
  /// In rw, this message translates to:
  /// **'Isomero'**
  String get library;

  /// No description provided for @openLibrary.
  ///
  /// In rw, this message translates to:
  /// **'Fungura isomero'**
  String get openLibrary;

  /// No description provided for @letterNumber.
  ///
  /// In rw, this message translates to:
  /// **'Ibaruwa ya {number}'**
  String letterNumber(Object number);

  /// No description provided for @readingProgress.
  ///
  /// In rw, this message translates to:
  /// **'Wageze kuri {percent} %'**
  String readingProgress(Object percent);

  /// No description provided for @downloadPdf.
  ///
  /// In rw, this message translates to:
  /// **'Kurura PDF'**
  String get downloadPdf;

  /// No description provided for @downloadAudio.
  ///
  /// In rw, this message translates to:
  /// **'Kurura amajwi'**
  String get downloadAudio;

  /// No description provided for @downloadPack.
  ///
  /// In rw, this message translates to:
  /// **'Kurura byose'**
  String get downloadPack;

  /// No description provided for @downloaded.
  ///
  /// In rw, this message translates to:
  /// **'Byakurujwe'**
  String get downloaded;

  /// No description provided for @notDownloaded.
  ///
  /// In rw, this message translates to:
  /// **'Ntibirakururwa'**
  String get notDownloaded;

  /// No description provided for @downloading.
  ///
  /// In rw, this message translates to:
  /// **'Biracyakururwa'**
  String get downloading;

  /// No description provided for @downloadPaused.
  ///
  /// In rw, this message translates to:
  /// **'Byahagaritswe'**
  String get downloadPaused;

  /// No description provided for @downloadFailed.
  ///
  /// In rw, this message translates to:
  /// **'Byanze'**
  String get downloadFailed;

  /// No description provided for @downloadCompleted.
  ///
  /// In rw, this message translates to:
  /// **'Byarangiye'**
  String get downloadCompleted;

  /// No description provided for @downloadPending.
  ///
  /// In rw, this message translates to:
  /// **'Bitegereje'**
  String get downloadPending;

  /// No description provided for @downloadRetry.
  ///
  /// In rw, this message translates to:
  /// **'Ongera'**
  String get downloadRetry;

  /// No description provided for @downloadCancel.
  ///
  /// In rw, this message translates to:
  /// **'Hagarika'**
  String get downloadCancel;

  /// No description provided for @downloadDelete.
  ///
  /// In rw, this message translates to:
  /// **'Siba dosiye'**
  String get downloadDelete;

  /// No description provided for @downloadsTitle.
  ///
  /// In rw, this message translates to:
  /// **'Ibikururwa'**
  String get downloadsTitle;

  /// No description provided for @downloadsEmpty.
  ///
  /// In rw, this message translates to:
  /// **'Nta dosiye zirakururwa.'**
  String get downloadsEmpty;

  /// No description provided for @downloadsEmptyHint.
  ///
  /// In rw, this message translates to:
  /// **'Fungura ibaruwa ukurure PDF cyangwa amajwi.'**
  String get downloadsEmptyHint;

  /// No description provided for @storageUsed.
  ///
  /// In rw, this message translates to:
  /// **'Ahari mu telefoni'**
  String get storageUsed;

  /// No description provided for @storageSummary.
  ///
  /// In rw, this message translates to:
  /// **'{used} byakoreshejwe'**
  String storageSummary(Object used);

  /// No description provided for @storageUnavailable.
  ///
  /// In rw, this message translates to:
  /// **'Ingano y’ububiko ntiboneka'**
  String get storageUnavailable;

  /// No description provided for @insufficientSpace.
  ///
  /// In rw, this message translates to:
  /// **'Ububiko ntibuhagije kuri iyi dosiye.'**
  String get insufficientSpace;

  /// No description provided for @offlineMessage.
  ///
  /// In rw, this message translates to:
  /// **'Nta murandasi. Amakuru yabitswe arakoreshwa.'**
  String get offlineMessage;

  /// No description provided for @onlineMessage.
  ///
  /// In rw, this message translates to:
  /// **'Umeruje kuri interineti.'**
  String get onlineMessage;

  /// No description provided for @syncError.
  ///
  /// In rw, this message translates to:
  /// **'Guhuza amakuru byanze.'**
  String get syncError;

  /// No description provided for @syncSuccess.
  ///
  /// In rw, this message translates to:
  /// **'Amakuru yahujwe.'**
  String get syncSuccess;

  /// No description provided for @syncNow.
  ///
  /// In rw, this message translates to:
  /// **'Huza nonaha'**
  String get syncNow;

  /// No description provided for @lastSync.
  ///
  /// In rw, this message translates to:
  /// **'Guhuza kwa nyuma'**
  String get lastSync;

  /// No description provided for @neverSynced.
  ///
  /// In rw, this message translates to:
  /// **'Ntibyigeze bihuzwa'**
  String get neverSynced;

  /// No description provided for @firstLaunchOffline.
  ///
  /// In rw, this message translates to:
  /// **'Nta murandasi, kandi nta makuru yabitswe kuri telefoni. Huza interineti ugerageze.'**
  String get firstLaunchOffline;

  /// No description provided for @errorLoading.
  ///
  /// In rw, this message translates to:
  /// **'Hari ikibazo mu gupakira amakuru.'**
  String get errorLoading;

  /// No description provided for @emptyLetters.
  ///
  /// In rw, this message translates to:
  /// **'Nta baruwa zirabona.'**
  String get emptyLetters;

  /// No description provided for @source.
  ///
  /// In rw, this message translates to:
  /// **'Inkomoko'**
  String get source;

  /// No description provided for @attribution.
  ///
  /// In rw, this message translates to:
  /// **'Inkomoko: inzirayakristu.com'**
  String get attribution;

  /// No description provided for @fontSize.
  ///
  /// In rw, this message translates to:
  /// **'Ingano y’inyandiko'**
  String get fontSize;

  /// No description provided for @decreaseFont.
  ///
  /// In rw, this message translates to:
  /// **'Gabanura inyandiko'**
  String get decreaseFont;

  /// No description provided for @increaseFont.
  ///
  /// In rw, this message translates to:
  /// **'Ongera inyandiko'**
  String get increaseFont;

  /// No description provided for @theme.
  ///
  /// In rw, this message translates to:
  /// **'Uburyo bw’amabara'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In rw, this message translates to:
  /// **'Uburyo bwa sisitemu'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In rw, this message translates to:
  /// **'Uburyo bwera'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In rw, this message translates to:
  /// **'Uburyo bwijimye'**
  String get themeDark;

  /// No description provided for @about.
  ///
  /// In rw, this message translates to:
  /// **'Ibyerekeye'**
  String get about;

  /// No description provided for @version.
  ///
  /// In rw, this message translates to:
  /// **'Verisiyo {version}'**
  String version(Object version);

  /// No description provided for @speed.
  ///
  /// In rw, this message translates to:
  /// **'Umuvuduko'**
  String get speed;

  /// No description provided for @sleepTimer.
  ///
  /// In rw, this message translates to:
  /// **'Guhagarika amajwi'**
  String get sleepTimer;

  /// No description provided for @sleepOff.
  ///
  /// In rw, this message translates to:
  /// **'Ntibihagarara'**
  String get sleepOff;

  /// No description provided for @minutes15.
  ///
  /// In rw, this message translates to:
  /// **'Iminota 15'**
  String get minutes15;

  /// No description provided for @minutes30.
  ///
  /// In rw, this message translates to:
  /// **'Iminota 30'**
  String get minutes30;

  /// No description provided for @minutes60.
  ///
  /// In rw, this message translates to:
  /// **'Iminota 60'**
  String get minutes60;

  /// No description provided for @skipBack15.
  ///
  /// In rw, this message translates to:
  /// **'Subiza amasegonda 15'**
  String get skipBack15;

  /// No description provided for @skipForward15.
  ///
  /// In rw, this message translates to:
  /// **'Jugunya amasegonda 15'**
  String get skipForward15;

  /// No description provided for @play.
  ///
  /// In rw, this message translates to:
  /// **'Tangiza'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In rw, this message translates to:
  /// **'Hagarika'**
  String get pause;

  /// No description provided for @miniPlayer.
  ///
  /// In rw, this message translates to:
  /// **'Umva amajwi'**
  String get miniPlayer;

  /// No description provided for @readingSettings.
  ///
  /// In rw, this message translates to:
  /// **'Igenamiterere ry’ugusoma'**
  String get readingSettings;

  /// No description provided for @pdfTitle.
  ///
  /// In rw, this message translates to:
  /// **'PDF y’ibaruwa'**
  String get pdfTitle;

  /// No description provided for @audioTitle.
  ///
  /// In rw, this message translates to:
  /// **'Amajwi y’ibaruwa'**
  String get audioTitle;

  /// No description provided for @audioShort.
  ///
  /// In rw, this message translates to:
  /// **'Amajwi'**
  String get audioShort;

  /// No description provided for @fontPreview.
  ///
  /// In rw, this message translates to:
  /// **'Urugero rw’inyandiko y’ibaruwa.'**
  String get fontPreview;

  /// No description provided for @sleepActive.
  ///
  /// In rw, this message translates to:
  /// **'Guhagarika amajwi bikora'**
  String get sleepActive;

  /// No description provided for @nowPlaying.
  ///
  /// In rw, this message translates to:
  /// **'Birakina'**
  String get nowPlaying;

  /// No description provided for @unavailableOnServer.
  ///
  /// In rw, this message translates to:
  /// **'Ntiboneka kuri seriveri'**
  String get unavailableOnServer;

  /// No description provided for @noAudio.
  ///
  /// In rw, this message translates to:
  /// **'Nta majwi abonetse kuri iyi baruwa.'**
  String get noAudio;

  /// No description provided for @noPdf.
  ///
  /// In rw, this message translates to:
  /// **'Nta PDF ibonetse kuri iyi baruwa.'**
  String get noPdf;

  /// No description provided for @favoriteAdded.
  ///
  /// In rw, this message translates to:
  /// **'Yongewe mu bikunzwe.'**
  String get favoriteAdded;

  /// No description provided for @favoriteRemoved.
  ///
  /// In rw, this message translates to:
  /// **'Yakuwe mu bikunzwe.'**
  String get favoriteRemoved;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In rw, this message translates to:
  /// **'Siba dosiye ?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In rw, this message translates to:
  /// **'Dosiye izasibwa, ariko inyandiko y’ibaruwa izaguma.'**
  String get deleteConfirmBody;

  /// No description provided for @downloadUnavailable.
  ///
  /// In rw, this message translates to:
  /// **'Gukurura ntibishoboka ubu.'**
  String get downloadUnavailable;

  /// No description provided for @invalidFile.
  ///
  /// In rw, this message translates to:
  /// **'Dosiye ntuzuye cyangwa yononekare. Ongera ugerageze.'**
  String get invalidFile;

  /// No description provided for @interruptedDownload.
  ///
  /// In rw, this message translates to:
  /// **'Gukurura byahagaritswe. Ongera ugerageze.'**
  String get interruptedDownload;

  /// No description provided for @resume.
  ///
  /// In rw, this message translates to:
  /// **'Komeza'**
  String get resume;

  /// No description provided for @lastRead.
  ///
  /// In rw, this message translates to:
  /// **'Wasomye {date}'**
  String lastRead(Object date);

  /// No description provided for @updatedAt.
  ///
  /// In rw, this message translates to:
  /// **'Byavuguruwe {date}'**
  String updatedAt(Object date);

  /// No description provided for @languageName.
  ///
  /// In rw, this message translates to:
  /// **'Ikinyarwanda'**
  String get languageName;

  /// No description provided for @letterNotFound.
  ///
  /// In rw, this message translates to:
  /// **'Iyi baruwa ntabonetse.'**
  String get letterNotFound;

  /// No description provided for @loading.
  ///
  /// In rw, this message translates to:
  /// **'Birakora…'**
  String get loading;

  /// No description provided for @menu.
  ///
  /// In rw, this message translates to:
  /// **'Ibikubiyemo'**
  String get menu;

  /// No description provided for @openPdf.
  ///
  /// In rw, this message translates to:
  /// **'Fungura PDF'**
  String get openPdf;

  /// No description provided for @openAudio.
  ///
  /// In rw, this message translates to:
  /// **'Fungura amajwi'**
  String get openAudio;

  /// No description provided for @downloadInProgress.
  ///
  /// In rw, this message translates to:
  /// **'Biracyakururwa…'**
  String get downloadInProgress;

  /// No description provided for @readText.
  ///
  /// In rw, this message translates to:
  /// **'Soma inyandiko'**
  String get readText;

  /// No description provided for @audioUnavailableOffline.
  ///
  /// In rw, this message translates to:
  /// **'Amajwi ntaboneka nta murandasi. Kurura mbere.'**
  String get audioUnavailableOffline;

  /// No description provided for @pdfUnavailableOffline.
  ///
  /// In rw, this message translates to:
  /// **'PDF ntaboneka nta murandasi. Kurura mbere.'**
  String get pdfUnavailableOffline;

  /// No description provided for @dataSync.
  ///
  /// In rw, this message translates to:
  /// **'Guhuza amakuru'**
  String get dataSync;

  /// No description provided for @clearDownloads.
  ///
  /// In rw, this message translates to:
  /// **'Siba ibyakurujwe'**
  String get clearDownloads;

  /// No description provided for @clearDownloadsBody.
  ///
  /// In rw, this message translates to:
  /// **'Dosiye zose zikurujwe zizasibwa, inyandiko zo mu mabaruwa zizaguma.'**
  String get clearDownloadsBody;

  /// No description provided for @clear.
  ///
  /// In rw, this message translates to:
  /// **'Siba byose'**
  String get clear;

  /// No description provided for @onboardingSkip.
  ///
  /// In rw, this message translates to:
  /// **'Komeza'**
  String get onboardingSkip;

  /// No description provided for @today.
  ///
  /// In rw, this message translates to:
  /// **'Uyu munsi'**
  String get today;

  /// No description provided for @older.
  ///
  /// In rw, this message translates to:
  /// **'Byabitswe'**
  String get older;

  /// No description provided for @downloadSpaceCheck.
  ///
  /// In rw, this message translates to:
  /// **'Kugenzura ububiko…'**
  String get downloadSpaceCheck;

  /// No description provided for @fileVerified.
  ///
  /// In rw, this message translates to:
  /// **'Dosiye yagenzuwe'**
  String get fileVerified;

  /// No description provided for @fileInvalid.
  ///
  /// In rw, this message translates to:
  /// **'Dosiye ntiyagenzuwe'**
  String get fileInvalid;

  /// No description provided for @noInternet.
  ///
  /// In rw, this message translates to:
  /// **'Nta murandasi'**
  String get noInternet;

  /// No description provided for @connected.
  ///
  /// In rw, this message translates to:
  /// **'Umeruje'**
  String get connected;

  /// No description provided for @notConnected.
  ///
  /// In rw, this message translates to:
  /// **'Ntabwo umeruje'**
  String get notConnected;

  /// No description provided for @syncOffline.
  ///
  /// In rw, this message translates to:
  /// **'Ntibishoboka guhuza nta murandasi.'**
  String get syncOffline;

  /// No description provided for @sourceLink.
  ///
  /// In rw, this message translates to:
  /// **'Reba inkomoko'**
  String get sourceLink;

  /// No description provided for @shareText.
  ///
  /// In rw, this message translates to:
  /// **'{title} — Inkomoko: inzirayakristu.com'**
  String shareText(Object title);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['rw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'rw':
      return AppLocalizationsRw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
