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
