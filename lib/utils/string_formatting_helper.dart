class StringFormattingHelper {
  static String trimAndCapitalizeWords(String s) {
    List<String> words = s.split('_');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toLowerCase();
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  static String formatCityName(String s) {
    String word = s.toLowerCase();
    List<String> words = word.split(' ');
    return words.join('_');
  }

  static String capitalizeWords(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }
}
