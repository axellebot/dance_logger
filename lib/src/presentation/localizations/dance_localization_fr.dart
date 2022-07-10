import 'dart:async';

import 'package:dance/src/presentation/localizations/dance_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DanceLocalizationsFR implements DanceLocalizations {
  const DanceLocalizationsFR();

  /// --------------------------------------------------------------------------
  ///                                Common
  /// --------------------------------------------------------------------------

  @override
  String get token => 'Jeton';

  @override
  String get cancelCTA => 'Annuler';

  @override
  String get account => 'Compte';

  @override
  String get home => 'Accueil';

  @override
  String get resume => 'CV';

  @override
  String get profile => 'Profil';

  @override
  String get search => 'Rechercher';

  @override
  String get history => 'Historique';

  @override
  String get loadMore => 'Charger plus';

  @override
  String get retryCTA => 'Re-éssayer';

  @override
  String get yesCTA => 'Oui';

  @override
  String get noCTA => 'Non';

  @override
  String get moreCTA => 'Plus';

  @override
  String get errorOccurred => 'Une erreur s\'est produite.';

  /// --------------------------------------------------------------------------
  ///                                   App
  /// --------------------------------------------------------------------------

  @override
  String get appName => 'Dance App';

  /// --------------------------------------------------------------------------
  ///                             Menu Widget
  /// --------------------------------------------------------------------------

  @override
  String get menuPPCTA => 'Politique de confidentialité';

  @override
  String get menuToSCTA => 'Termes de Service';

  /// --------------------------------------------------------------------------
  ///                               Home Page
  /// --------------------------------------------------------------------------

  @override
  String get homeTitle => 'Dance';

  @override
  String get homeCTA => 'Accueil';

  @override
  String get homeWelcome => 'Bienvenue sur notre nouveau réseau social de CV !';

  /// Settings Pages

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsCTA => 'Paramètres';

  @override
  String get settingsThemeModeCTA => 'Thème';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeDarkUltra => "Ultra sombre";

  /// Search Page

  @override
  String get searchTitle => 'Recherche';

  @override
  String get searchSearchBarHint => 'Rechercher un profil ...';

  /// --------------------------------------------------------------------------
  ///                                Forms
  /// --------------------------------------------------------------------------

  @override
  String get formUsernameLabel => 'Nom d\'utilisateur';

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
  String get errorNotYetImplemented => 'Pas encore implémenté';

  @override
  String get errorNotSupported => 'Non supporté';

  /// --------------------------------------------------------------------------
  ///                            Others Exceptions
  /// --------------------------------------------------------------------------

  @override
  String get exceptionFormatException => 'Exception : Mauvais Format';

  @override
  String get exceptionTimeoutException => 'Exception : Requete Expiré';

  /// --------------------------------------------------------------------------
  ///                       HTTP Client Error (4XX)
  /// --------------------------------------------------------------------------

  @override
  String get http400ClientErrorBadRequest => 'Mauvaise requete';

  @override
  String get http401ClientErrorUnauthorized => 'Non authorisé';

  @override
  String get http402ClientErrorPaymentRequired => 'Paiement requis';

  @override
  String get http403ClientErrorForbidden => 'Interdit';

  @override
  String get http404ClientErrorNotFound => 'Introuvable';

  @override
  String get http405ClientErrorMethodNotAllowed => 'Non autorisé';

  @override
  String get http406ClientErrorNotAcceptable => 'Non acceptable';

  @override
  String get http408ClientErrorRequestTimeout => 'Requete expirée';

  @override
  String get http409ClientErrorConflict => 'Conflit';

  @override
  String get http410ClientErrorGone => 'Disparu';

  @override
  String get http411ClientErrorLengthRequired => 'Taille requise';

  @override
  String get http413ClientErrorPayloadTooLarge => 'Payload trop large';

  @override
  String get http414ClientErrorURITooLong => 'Lien trop long';

  @override
  String get http415ClientErrorUnsupportedMediaType =>
      'Type de média non supporté';

  @override
  String get http417ClientErrorExpectationFailed => 'Échoué';

  @override
  String get http426ClientErrorUpgradeRequired => 'Mise à jour requise';

  /// --------------------------------------------------------------------------
  ///                       HTTP Server Error (5XX)
  /// --------------------------------------------------------------------------

  @override
  String get http500ServerErrorInternalServerError => 'Erreur Serveur interne';

  @override
  String get http501ServerErrorNotImplemented => 'Non implementé';

  @override
  String get http502ServerErrorBadGateway => 'Mauvaise passerelle';

  @override
  String get http503ServerErrorServiceUnavailable => 'Service non disponible ';

  @override
  String get http504ServerErrorGatewayTimeout => 'Temps ecoulé';

  @override
  String get http505ServerErrorHttpVersionNotSupported =>
      'Version HTTP non supporté';

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
    return SynchronousFuture<DanceLocalizations>(const DanceLocalizationsFR());
  }

  /// A [LocalizationsDelegate] that uses [DanceLocalizationsFR.load]
  /// to create an instance of this class.
  ///
  /// [MaterialApp] automatically adds this value to [MaterialApp.localizationsDelegates].
  static const LocalizationsDelegate<DanceLocalizations> delegate =
      DanceLocalizationsDelegate();
}
