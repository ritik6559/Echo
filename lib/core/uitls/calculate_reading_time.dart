int calculateReadingTime(String content) {
  final wordcount = content.split(RegExp(r'\s+')).length;

  final readingTime = wordcount / 225;

  return readingTime.ceil();
}
