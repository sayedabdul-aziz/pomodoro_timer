List<String> formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);
  String minutes = (duration.inMinutes).toString().padLeft(2, '0');
  String remainingSeconds =
      (duration.inSeconds.remainder(60)).toString().padLeft(2, '0');
  return [minutes, remainingSeconds];
}
