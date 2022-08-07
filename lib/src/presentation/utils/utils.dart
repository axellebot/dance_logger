
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

bool isYoutube(String url) {
  RegExp regex = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$');
  return regex.hasMatch(url);
}

String? getYoutubeId(String url) {
  RegExp regex = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*');
  RegExpMatch match = regex.firstMatch(url)!;
  return (match[7]?.length == 11) ? match[7] : null;
}

EdgeInsets calculateDefaultPadding(BuildContext context) {
  TargetPlatform platform = defaultTargetPlatform;
  if (MediaQuery.of(context).size.width > 810) {
    double padding = (MediaQuery.of(context).size.width - 810) / 2;
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return EdgeInsets.symmetric(horizontal: padding);
      // case TargetPlatform.web:
      //   return EdgeInsets.symmetric(vertical: 20, horizontal: padding);
      default:
        return EdgeInsets.symmetric(
          horizontal: padding,
        );
    }
  }
  switch (platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
    default:
      return const EdgeInsets.symmetric(vertical: 0);
    // case TargetPlatform.web:
    //   return const EdgeInsets.symmetric(vertical: 20);
  }
}