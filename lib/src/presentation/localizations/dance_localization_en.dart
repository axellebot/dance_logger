import 'dart:async';

import 'package:dance/src/presentation/localizations/dance_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DanceLocalizationsEN implements DanceLocalizations {
  const DanceLocalizationsEN();

  /// --------------------------------------------------------------------------
  ///                                Common
  /// --------------------------------------------------------------------------

  @override
  String get token => 'Token';

  @override
  String get cancelCTA => 'Cancel';

  @override
  String get settingsCTA => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get home => 'Home';

  @override
  String get resume => 'Resume';

  @override
  String get profile => 'Profile';

  @override
  String get search => 'Search';

  @override
  String get history => 'History';

  @override
  String get loadMore => 'Load more';

  @override
  String get retryCTA => 'Retry';

  @override
  String get yesCTA => 'Yes';

  @override
  String get noCTA => 'No';

  @override
  String get moreCTA => 'More';

  @override
  String get errorOccurred => 'An error occurred';

  /// --------------------------------------------------------------------------
  ///                                   App
  /// --------------------------------------------------------------------------

  @override
  String get appName => 'Dance App';

  /// --------------------------------------------------------------------------
  ///                             Menu Widget
  /// --------------------------------------------------------------------------

  @override
  String get menuPPCTA => 'Privacy Policy';

  @override
  String get menuToSCTA => 'Terms of Service';

  /// --------------------------------------------------------------------------
  ///                               Home Page
  /// --------------------------------------------------------------------------

  @override
  String get homeTitle => 'Dance';

  @override
  String get homeCTA => 'Home';

  @override
  String get homeWelcome => 'Welcome on our new resume social network !';

  /// --------------------------------------------------------------------------
  ///                 Authentication Page - Login - SignUp
  /// --------------------------------------------------------------------------

  /// --------------------------------------------------------------------------
  ///                              Setting Page
  /// --------------------------------------------------------------------------

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeModeCTA => 'Theme Mode';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeDarkUltra => "Darkest";

  /// Search Page

  @override
  String get searchTitle => 'Search';

  @override
  String get searchSearchBarHint => 'Search resume...';

  /// --------------------------------------------------------------------------
  ///                                Forms
  /// --------------------------------------------------------------------------

  @override
  String get formUsernameLabel => 'Username';

  @override
  String get formEmailLabel => 'Email';

  @override
  String get formEmailHint => 'someone@email.com';

  @override
  String get formNotEmailExplain => 'Please enter a real e-mail.';

  @override
  String get formNoEmailExplain => 'Please provide an email';

  @override
  String get formPasswordLabel => 'Password';

  @override
  String get formNoPasswordExplain => 'Please provide a password';

  @override
  String get formPassword2Label => 'Repeat password';

  @override
  String get formPasswordWrongPolicy =>
      'The password do not fit to our password policy.';

  /// --------------------------------------------------------------------------
  ///                            App Errors
  /// --------------------------------------------------------------------------

  @override
  String get errorNotYetImplemented => 'Not yet implemented';

  @override
  String get errorNotSupported => 'Not supported';

  /// --------------------------------------------------------------------------
  ///                            Others Exceptions
  /// --------------------------------------------------------------------------

  @override
  String get exceptionFormatException => 'Exception : Wrong Format';

  @override
  String get exceptionTimeoutException => 'Exception : Request Timeout';

  /// --------------------------------------------------------------------------
  ///                       HTTP Client Error (4XX)
  /// --------------------------------------------------------------------------

  @override
  String get http400ClientErrorBadRequest => 'Bad request';

  @override
  String get http401ClientErrorUnauthorized => 'Unauthorized';

  @override
  String get http402ClientErrorPaymentRequired => 'Payment required';

  @override
  String get http403ClientErrorForbidden => 'Forbidden';

  @override
  String get http404ClientErrorNotFound => 'Not found';

  @override
  String get http405ClientErrorMethodNotAllowed => 'Not allowed';

  @override
  String get http406ClientErrorNotAcceptable => 'Not acceptable';

  @override
  String get http408ClientErrorRequestTimeout => 'Request timeout';

  @override
  String get http409ClientErrorConflict => 'Conflict';

  @override
  String get http410ClientErrorGone => 'Gone';

  @override
  String get http411ClientErrorLengthRequired => 'Length required';

  @override
  String get http413ClientErrorPayloadTooLarge => 'Payload too large';

  @override
  String get http414ClientErrorURITooLong => 'URI too long';

  @override
  String get http415ClientErrorUnsupportedMediaType => 'Unsupported media type';

  @override
  String get http417ClientErrorExpectationFailed => 'Expectation Failed';

  @override
  String get http426ClientErrorUpgradeRequired => 'Upgrade required';

  /// --------------------------------------------------------------------------
  ///                       HTTP Server Error (5XX)
  /// --------------------------------------------------------------------------

  @override
  String get http500ServerErrorInternalServerError => 'Internal Server Error';

  @override
  String get http501ServerErrorNotImplemented => 'Not implemented';

  @override
  String get http502ServerErrorBadGateway => 'Bad Gateway';

  @override
  String get http503ServerErrorServiceUnavailable => 'Service Unavailable';

  @override
  String get http504ServerErrorGatewayTimeout => 'Gateway Timeout';

  @override
  String get http505ServerErrorHttpVersionNotSupported =>
      'HTTP Version Not Supported';

  /// --------------------------------------------------------------------------
  ///                                 Misc
  /// --------------------------------------------------------------------------

  /// Creates an object that provides US English resource values for the
  /// application.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  /// The [MaterialApp] does so by default.
  static FutureOr<DanceLocalizations> load(Locale locale) {
    return SynchronousFuture<DanceLocalizations>(const DanceLocalizationsEN());
  }

  /// A [LocalizationsDelegate] that uses [DanceLocalizationsEN.load]
  /// to create an instance of this class.
  ///
  /// [MaterialApp] automatically adds this value to [MaterialApp.localizationsDelegates].
  static const LocalizationsDelegate<DanceLocalizations> delegate =
      DanceLocalizationsDelegate();
}
