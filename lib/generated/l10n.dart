// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Token`
  String get token {
    return Intl.message(
      'Token',
      name: 'token',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelCTA {
    return Intl.message(
      'Cancel',
      name: 'cancelCTA',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsCTA {
    return Intl.message(
      'Settings',
      name: 'settingsCTA',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Load more`
  String get loadMore {
    return Intl.message(
      'Load more',
      name: 'loadMore',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryCTA {
    return Intl.message(
      'Retry',
      name: 'retryCTA',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yesCTA {
    return Intl.message(
      'Yes',
      name: 'yesCTA',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get noCTA {
    return Intl.message(
      'No',
      name: 'noCTA',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get moreCTA {
    return Intl.message(
      'More',
      name: 'moreCTA',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Dance App`
  String get appName {
    return Intl.message(
      'Dance App',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteCTA {
    return Intl.message(
      'Delete',
      name: 'deleteCTA',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get menuPPCTA {
    return Intl.message(
      'Privacy Policy',
      name: 'menuPPCTA',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get menuToSCTA {
    return Intl.message(
      'Terms of Service',
      name: 'menuToSCTA',
      desc: '',
      args: [],
    );
  }

  /// `Dance`
  String get homeTitle {
    return Intl.message(
      'Dance',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeCTA {
    return Intl.message(
      'Home',
      name: 'homeCTA',
      desc: '',
      args: [],
    );
  }

  /// `Welcome on our new resume social network !`
  String get homeWelcome {
    return Intl.message(
      'Welcome on our new resume social network !',
      name: 'homeWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get settingsThemeModeCTA {
    return Intl.message(
      'Theme Mode',
      name: 'settingsThemeModeCTA',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get settingsThemeSystem {
    return Intl.message(
      'System',
      name: 'settingsThemeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settingsThemeLight {
    return Intl.message(
      'Light',
      name: 'settingsThemeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settingsThemeDark {
    return Intl.message(
      'Dark',
      name: 'settingsThemeDark',
      desc: '',
      args: [],
    );
  }

  /// `Darkest`
  String get settingsThemeDarkUltra {
    return Intl.message(
      'Darkest',
      name: 'settingsThemeDarkUltra',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchTitle {
    return Intl.message(
      'Search',
      name: 'searchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search resume...`
  String get searchSearchBarHint {
    return Intl.message(
      'Search resume...',
      name: 'searchSearchBarHint',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get formUsernameLabel {
    return Intl.message(
      'Username',
      name: 'formUsernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get formEmailLabel {
    return Intl.message(
      'Email',
      name: 'formEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `someone@email.com`
  String get formEmailHint {
    return Intl.message(
      'someone@email.com',
      name: 'formEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a real e-mail.`
  String get formNotEmailExplain {
    return Intl.message(
      'Please enter a real e-mail.',
      name: 'formNotEmailExplain',
      desc: '',
      args: [],
    );
  }

  /// `Please provide an email`
  String get formNoEmailExplain {
    return Intl.message(
      'Please provide an email',
      name: 'formNoEmailExplain',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get formPasswordLabel {
    return Intl.message(
      'Password',
      name: 'formPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a password`
  String get formNoPasswordExplain {
    return Intl.message(
      'Please provide a password',
      name: 'formNoPasswordExplain',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get formPassword2Label {
    return Intl.message(
      'Repeat password',
      name: 'formPassword2Label',
      desc: '',
      args: [],
    );
  }

  /// `The password do not fit to our password policy.`
  String get formPasswordWrongPolicy {
    return Intl.message(
      'The password do not fit to our password policy.',
      name: 'formPasswordWrongPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Not yet implemented`
  String get errorNotYetImplemented {
    return Intl.message(
      'Not yet implemented',
      name: 'errorNotYetImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Not supported`
  String get errorNotSupported {
    return Intl.message(
      'Not supported',
      name: 'errorNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `Exception : Wrong Format`
  String get exceptionFormatException {
    return Intl.message(
      'Exception : Wrong Format',
      name: 'exceptionFormatException',
      desc: '',
      args: [],
    );
  }

  /// `Exception : Request Timeout`
  String get exceptionTimeoutException {
    return Intl.message(
      'Exception : Request Timeout',
      name: 'exceptionTimeoutException',
      desc: '',
      args: [],
    );
  }

  /// `Bad request`
  String get http400ClientErrorBadRequest {
    return Intl.message(
      'Bad request',
      name: 'http400ClientErrorBadRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get http401ClientErrorUnauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'http401ClientErrorUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Payment required`
  String get http402ClientErrorPaymentRequired {
    return Intl.message(
      'Payment required',
      name: 'http402ClientErrorPaymentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Forbidden`
  String get http403ClientErrorForbidden {
    return Intl.message(
      'Forbidden',
      name: 'http403ClientErrorForbidden',
      desc: '',
      args: [],
    );
  }

  /// `Not found`
  String get http404ClientErrorNotFound {
    return Intl.message(
      'Not found',
      name: 'http404ClientErrorNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Not allowed`
  String get http405ClientErrorMethodNotAllowed {
    return Intl.message(
      'Not allowed',
      name: 'http405ClientErrorMethodNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Not acceptable`
  String get http406ClientErrorNotAcceptable {
    return Intl.message(
      'Not acceptable',
      name: 'http406ClientErrorNotAcceptable',
      desc: '',
      args: [],
    );
  }

  /// `Request timeout`
  String get http408ClientErrorRequestTimeout {
    return Intl.message(
      'Request timeout',
      name: 'http408ClientErrorRequestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Conflict`
  String get http409ClientErrorConflict {
    return Intl.message(
      'Conflict',
      name: 'http409ClientErrorConflict',
      desc: '',
      args: [],
    );
  }

  /// `Gone`
  String get http410ClientErrorGone {
    return Intl.message(
      'Gone',
      name: 'http410ClientErrorGone',
      desc: '',
      args: [],
    );
  }

  /// `Length required`
  String get http411ClientErrorLengthRequired {
    return Intl.message(
      'Length required',
      name: 'http411ClientErrorLengthRequired',
      desc: '',
      args: [],
    );
  }

  /// `Payload too large`
  String get http413ClientErrorPayloadTooLarge {
    return Intl.message(
      'Payload too large',
      name: 'http413ClientErrorPayloadTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `URI too long`
  String get http414ClientErrorURITooLong {
    return Intl.message(
      'URI too long',
      name: 'http414ClientErrorURITooLong',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported media type`
  String get http415ClientErrorUnsupportedMediaType {
    return Intl.message(
      'Unsupported media type',
      name: 'http415ClientErrorUnsupportedMediaType',
      desc: '',
      args: [],
    );
  }

  /// `Expectation Failed`
  String get http417ClientErrorExpectationFailed {
    return Intl.message(
      'Expectation Failed',
      name: 'http417ClientErrorExpectationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade required`
  String get http426ClientErrorUpgradeRequired {
    return Intl.message(
      'Upgrade required',
      name: 'http426ClientErrorUpgradeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error`
  String get http500ServerErrorInternalServerError {
    return Intl.message(
      'Internal Server Error',
      name: 'http500ServerErrorInternalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Not implemented`
  String get http501ServerErrorNotImplemented {
    return Intl.message(
      'Not implemented',
      name: 'http501ServerErrorNotImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Bad Gateway`
  String get http502ServerErrorBadGateway {
    return Intl.message(
      'Bad Gateway',
      name: 'http502ServerErrorBadGateway',
      desc: '',
      args: [],
    );
  }

  /// `Service Unavailable`
  String get http503ServerErrorServiceUnavailable {
    return Intl.message(
      'Service Unavailable',
      name: 'http503ServerErrorServiceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Gateway Timeout`
  String get http504ServerErrorGatewayTimeout {
    return Intl.message(
      'Gateway Timeout',
      name: 'http504ServerErrorGatewayTimeout',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Version Not Supported`
  String get http505ServerErrorHttpVersionNotSupported {
    return Intl.message(
      'HTTP Version Not Supported',
      name: 'http505ServerErrorHttpVersionNotSupported',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
