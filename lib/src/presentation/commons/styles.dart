import 'package:flutter/material.dart';

class AppStyles {
  /// --------------------------------------------------------------------------
  ///                           Commons Colors
  /// --------------------------------------------------------------------------

  static const Color colorBlue = Colors.blue;
  static const Color colorOrange = Colors.deepOrange;
  static const Color colorPink = Colors.pink;
  static const Color colorWhite = Colors.white;
  static const Color colorBlack = Colors.black;

  /// --------------------------------------------------------------------------
  ///                           Level Colors
  /// --------------------------------------------------------------------------

  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.yellow;

  /// --------------------------------------------------------------------------
  ///                            Basic Colors
  /// --------------------------------------------------------------------------

  static const Color primaryColorLight = Color(0xFF2196f3);
  static const Color primaryColorDark = Color(0xFF0069c0);
  static const Color primaryColorDarkUltra = Color(0xFF0069c0);
  static const Color secondaryColorLight = Color.fromARGB(255, 245, 82, 0);
  static const Color secondaryColorDark = Color.fromARGB(255, 188, 63, 0);
  static const Color secondaryColorDarkUltra = Color.fromARGB(255, 188, 63, 0);
  static const Color onPrimaryColorLight = Color(0xFFFFFFFF);
  static const Color onPrimaryColorDark = Color(0xFFFFFFFF);
  static const Color onSecondaryColorLight = Color(0xFFFFFFFF);
  static const Color onSecondaryColorDark = Color(0xFFFFFFFF);
  static const Color backgroundColorLight = Color(0xFFFFFFFF);
  static const Color backgroundColorDark = Color(0xFF3A3A3A);
  static const Color backgroundColorDarkUltra = Color.fromRGBO(0, 0, 0, 1);
  static const Color onBackgroundColorLight = Color(0xFF000000);
  static const Color onBackgroundColorDark = Color(0xFFFFFFFF);
  static const Color surfaceColorLight = Color(0xFFFFFFFF);
  static const Color surfaceColorDark = Color(0xFF3A3A3A);
  static const Color surfaceColorDarkUltra = Color(0xFF000000);
  static const Color onSurfaceColorLight = Color(0xFF000000);
  static const Color onSurfaceColorDark = Color(0xFFFFFFFF);
  static const Color errorColorLight = Color(0xFFFF0000);
  static const Color errorColorDark = Color(0xFFFF0000);
  static const Color errorColorDarkUltra = Color(0xFFFF0000);
  static const Color onErrorColorLight = Color(0xFFFFFFFF);
  static const Color onErrorColorDark = Color(0xFFFFFFFF);

  /// --------------------------------------------------------------------------
  ///                           Default dimensions
  /// --------------------------------------------------------------------------

  static const EdgeInsets formPadding = EdgeInsets.all(15.0);
  static const double formInputVerticalSpacing = 12.0;

  /// --------------------------------------------------------------------------
  ///                          NavigationBar
  /// --------------------------------------------------------------------------

  static const double navigationBarElevation = 10.0;
  static const double navigationBarHeight = 65;

  /// --------------------------------------------------------------------------
  ///                                Card
  /// --------------------------------------------------------------------------

  static const double cardElevation = 2.0;
  static const EdgeInsets cardPadding = EdgeInsets.all(15.0);
  static const double cardBorderRadius = 10.0;
  static const double cardWidth = 150.0;
  static const double cardHeight = 80.0;

  /// --------------------------------------------------------------------------
  ///                                Chip
  /// --------------------------------------------------------------------------

  static const double chipHeight = 30.0;

  /// --------------------------------------------------------------------------
  ///                               Sheet
  /// --------------------------------------------------------------------------

  static const double bottomSheetRadius = 10.0;

  /// --------------------------------------------------------------------------
  ///                                List
  /// --------------------------------------------------------------------------

  static const double listHeaderDefaultHeightMax = 40.0;
  static const double listHeaderDefaultHeightMin = 40.0;

  /// --------------------------------------------------------------------------
  ///                                App
  /// --------------------------------------------------------------------------

  static const double appBarIconHorizontalPadding = 16;

  /// --------------------------------------------------------------------------
  ///                                Auth
  /// --------------------------------------------------------------------------

  static const double authPageMinHeight = 800.0;
  static const Color authLoginGradientEnd = primaryColorLight;
  static const Color authLoginGradientStart = primaryColorDark;

  /// --------------------------------------------------------------------------
  ///                          Element Profile
  /// --------------------------------------------------------------------------

  static const double profileAvatarMin = 5.0;
  static const double profileAvatarMax = 50.0;
  static const double profileAvatarElevation = 2.0;

  /// --------------------------------------------------------------------------
  ///                              Video
  /// --------------------------------------------------------------------------

  static double videoThumbnailRadius = 10.0;
  static double artistThumbnailRadius = 20.0;

  /// Sort
  static const double sortDialogWidth = 200.0;
  static const double sortDialogHeight = 300.0;
}
