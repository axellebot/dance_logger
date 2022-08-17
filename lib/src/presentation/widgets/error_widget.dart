import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// [CustomErrorWidget] is a based widget for error
///
/// Must be initialized with an [error]
abstract class CustomErrorWidget extends StatelessWidget {
  final dynamic error;

  const CustomErrorWidget({
    super.key,
    required this.error,
  });
}

/// [ErrorIcon] is a [Icon] like widget to display error
///
/// See [Icon] widget for more documentation
class ErrorIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const ErrorIcon({
    super.key,
    this.icon = MdiIcons.alertCircleOutline,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? Theme.of(context).errorColor,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

/// [ErrorText] is a [Text] like widget like to display error
///
/// See [Text] widget for more documentation
class ErrorText extends CustomErrorWidget {
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  const ErrorText({
    super.key,
    required super.error,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.center,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      // translateError(context, error),
      error.toString(),
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// [ErrorRow] is a [Row] like widget to display [Error]
///
/// See [Row] widget for more documentation
class ErrorRow extends CustomErrorWidget {
  const ErrorRow({
    super.key,
    required super.error,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ErrorIcon(),
        Expanded(child: ErrorText(error: error)),
      ],
    );
  }
}

/// [ErrorTile] is a [ListTile] like widget to display error
///
/// See [ListTile] widget for more documentation
class ErrorTile extends CustomErrorWidget {
  const ErrorTile({
    super.key,
    required super.error,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ErrorIcon(),
      title:
          Text(AppLocalizations.of(context)?.errorOccurred ?? 'Error occurred'),
      subtitle: ErrorText(
        error: error,
        textAlign: TextAlign.left,
      ),
    );
  }
}

/// [ErrorCard] is a [Card] like widget to display error
///
/// See [Card] widget for more documentation
class ErrorCard extends CustomErrorWidget {
  final double? height;
  final double? width;

  const ErrorCard({
    super.key,
    required super.error,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppStyles.cardHeight,
      width: width ?? AppStyles.cardWidth,
      child: Center(
        child: Card(
          elevation: AppStyles.cardElevation,
          child: Container(
            padding: AppStyles.cardPadding,
            child: ErrorText(error: error),
          ),
        ),
      ),
    );
  }
}

/// [ErrorListView] is a [ListView] like widget to display error
///
/// See [ListView] widget for more documentation
class ErrorListView extends CustomErrorWidget {
  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const ErrorListView({
    super.key,
    required super.error,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = (scrollDirection == Axis.vertical)
        ? ErrorTile(error: error)
        : ErrorCard(error: error);
    return ListView(
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: <Widget>[
        errorWidget,
      ],
    );
  }
}

/// [ErrorPage] is a [Scaffold] like widget to display error
///
/// See [Scaffold] widget for more documentation
class ErrorPage extends CustomErrorWidget {
  final bool showAppBar;

  const ErrorPage({
    super.key,
    this.showAppBar = true,
    required super.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar() : null,
      body: Center(
        child: ErrorCard(
          error: error,
        ),
      ),
    );
  }
}

/// [ErrorApp] is a [MaterialApp] like widget to display error
///
/// See [MaterialApp] widget for more documentation
class ErrorApp extends CustomErrorWidget {
  const ErrorApp({
    super.key,
    required super.error,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ErrorPage(error: error),
      color: Theme.of(context).errorColor,
    );
  }
}
