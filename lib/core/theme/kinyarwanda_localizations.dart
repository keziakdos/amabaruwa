import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KinyarwandaMaterialLocalizations extends DefaultMaterialLocalizations {
  const KinyarwandaMaterialLocalizations();

  @override
  String get backButtonTooltip => 'Subira inyuma';

  @override
  String get closeButtonTooltip => 'Funga';

  @override
  String get deleteButtonTooltip => 'Siba';

  @override
  String get cancelButtonLabel => 'Hagarika';

  @override
  String get okButtonLabel => 'Byemejwe';

  @override
  String get continueButtonLabel => 'Komeza';

  @override
  String get copyButtonLabel => 'Koporora';

  @override
  String get pasteButtonLabel => 'Komeka';

  @override
  String get cutButtonLabel => 'Kata';

  @override
  String get selectAllButtonLabel => 'Hitamo byose';

  @override
  String get viewLicensesButtonLabel => 'Reba uruhushya';

  @override
  String get licensesPageTitle => 'Uruhushya';

  @override
  String get searchFieldLabel => 'Shakisha';

  @override
  String get showMenuTooltip => 'Ibikubiyemo';

  @override
  String get modalBarrierDismissLabel => 'Funga';

  @override
  String get dialogLabel => 'Ikiganiro';

  @override
  String get alertDialogLabel => 'Iburira';

  @override
  String get popupMenuLabel => 'Ibikubiyemo';

  @override
  String formatMediumDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  String formatShortDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  String formatCompactDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  String formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  String formatMonthYear(DateTime date) => '${date.month}/${date.year}';

  @override
  String formatYear(DateTime date) => '${date.year}';

  @override
  String get unspecifiedDate => 'Itaramenyeshwa';

  @override
  String get dateHelpText => 'umwaka-ukwezi-umunsi';
}

class KinyarwandaCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KinyarwandaCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(
      const DefaultCupertinoLocalizations(),
    );
  }

  @override
  bool shouldReload(KinyarwandaCupertinoLocalizationsDelegate old) => false;
}

class KinyarwandaMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KinyarwandaMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return SynchronousFuture<MaterialLocalizations>(
      const KinyarwandaMaterialLocalizations(),
    );
  }

  @override
  bool shouldReload(KinyarwandaMaterialLocalizationsDelegate old) => false;
}
