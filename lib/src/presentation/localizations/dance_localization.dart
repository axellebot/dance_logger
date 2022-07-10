import 'dart:async';

import 'package:dance/src/presentation/localizations/dance_localization_en.dart';
import 'package:dance/src/presentation/localizations/dance_localization_fr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class DanceLocalizations {
  static DanceLocalizations? of(BuildContext context) {
    return Localizations.of<DanceLocalizations>(context, DanceLocalizations);
  }

  /// --------------------------------------------------------------------------
  ///                                Common
  /// --------------------------------------------------------------------------

  String get token;

  String get cancelCTA;

  String get settingsCTA;

  String get account;

  String get home;

  String get resume;

  String get profile;

  String get search;

  String get history;

  String get loadMore;

  String get retryCTA;

  String get yesCTA;

  String get noCTA;

  String get moreCTA;

  String get errorOccurred;

  /// --------------------------------------------------------------------------
  ///                                   App
  /// --------------------------------------------------------------------------

  String get appName;

  /// --------------------------------------------------------------------------
  ///                             Menu Widget
  /// --------------------------------------------------------------------------

  String get menuPPCTA;

  String get menuToSCTA;

  /// --------------------------------------------------------------------------
  ///                               Home Page
  /// --------------------------------------------------------------------------

  String get homeTitle;

  String get homeCTA;

  String get homeWelcome;

  /// --------------------------------------------------------------------------
  ///                              Setting Page
  /// --------------------------------------------------------------------------

  String get settingsTitle;

  String get settingsThemeModeCTA;

  String get settingsThemeSystem;

  String get settingsThemeLight;

  String get settingsThemeDark;

  String get settingsThemeDarkUltra;

  /// Search Page

  String get searchTitle;

  String get searchSearchBarHint;

  /// --------------------------------------------------------------------------
  ///                                Forms
  /// --------------------------------------------------------------------------

  String get formUsernameLabel;

  String get formEmailLabel;

  String get formEmailHint;

  String get formNoEmailExplain;

  String get formNotEmailExplain;

  String get formPasswordLabel;

  String get formNoPasswordExplain;

  String get formPassword2Label;

  String get formPasswordWrongPolicy;

  /// --------------------------------------------------------------------------
  ///                             Exceptions
  /// --------------------------------------------------------------------------

  String get exceptionFormatException;

  String get exceptionTimeoutException;

  /// --------------------------------------------------------------------------
  ///                             Errors
  /// --------------------------------------------------------------------------

  String get errorNotYetImplemented;

  String get errorNotSupported;

  /// --------------------------------------------------------------------------
  ///                       HTTP Client Error (4XX)
  /// --------------------------------------------------------------------------

  String get http400ClientErrorBadRequest;

  String get http401ClientErrorUnauthorized;

  String get http402ClientErrorPaymentRequired;

  String get http403ClientErrorForbidden;

  String get http404ClientErrorNotFound;

  String get http405ClientErrorMethodNotAllowed;

  String get http406ClientErrorNotAcceptable;

  String get http408ClientErrorRequestTimeout;

  String get http409ClientErrorConflict;

  String get http410ClientErrorGone;

  String get http411ClientErrorLengthRequired;

  String get http413ClientErrorPayloadTooLarge;

  String get http414ClientErrorURITooLong;

  String get http415ClientErrorUnsupportedMediaType;

  String get http417ClientErrorExpectationFailed;

  String get http426ClientErrorUpgradeRequired;

  /// --------------------------------------------------------------------------
  ///                       HTTP Server Error (5XX)
  /// --------------------------------------------------------------------------

  String get http500ServerErrorInternalServerError;

  String get http501ServerErrorNotImplemented;

  String get http502ServerErrorBadGateway;

  String get http503ServerErrorServiceUnavailable;

  String get http504ServerErrorGatewayTimeout;

  String get http505ServerErrorHttpVersionNotSupported;
}

class DanceLocalizationsDelegate
    extends LocalizationsDelegate<DanceLocalizations> {
  const DanceLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<DanceLocalizations> load(Locale locale) async {
    final String name =
        (locale.countryCode != null && locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == 'fr') {
      return await DanceLocalizationsFR.load(locale);
    } else {
      return await DanceLocalizationsEN.load(locale);
    }
  }

  @override
  bool shouldReload(DanceLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultDanceLocalizations.delegate(en_US)';
}
