import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

String getInitials(String nameString) {
  if (nameString.isEmpty) return '';

  List<String> nameArray =
      nameString.replaceAll(RegExp(r'\s+\b|\b\s'), ' ').split(' ');
  String initials = ((nameArray[0])[0] ?? ' ') +
      (nameArray.length == 1 ? ' ' : (nameArray[nameArray.length - 1])[0]);

  return initials;
}

bool isYoutube(String? url) {
  if (url == null) return false;
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

String? printDuration(Duration? duration) {
  if (duration == null) return null;
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitHours = twoDigits(duration.inHours);
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '${twoDigitHours == '00' ? '' : '$twoDigitHours:'}$twoDigitMinutes:$twoDigitSeconds';
}

/// Formats duration in milliseconds to xx:xx:xx format.
String durationFormatter(int milliSeconds) {
  var seconds = milliSeconds ~/ 1000;
  final hours = seconds ~/ 3600;
  seconds = seconds % 3600;
  var minutes = seconds ~/ 60;
  seconds = seconds % 60;
  final hoursString = hours >= 10
      ? '$hours'
      : hours == 0
          ? '00'
          : '0$hours';
  final minutesString = minutes >= 10
      ? '$minutes'
      : minutes == 0
          ? '00'
          : '0$minutes';
  final secondsString = seconds >= 10
      ? '$seconds'
      : seconds == 0
          ? '00'
          : '0$seconds';
  final formattedTime =
      '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
  return formattedTime;
}
