class CapitalizarPalavras {
 static String capitalizar(String str) {
    String lowerCaseStr = str.toLowerCase();

    List<String> words = lowerCaseStr.split(' ');

    List<String> capitalizedWords = words.map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).toList();

    return capitalizedWords.join(' ');
  }
}