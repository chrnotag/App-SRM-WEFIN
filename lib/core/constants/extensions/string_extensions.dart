extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  String capitalizeCadaPalavra() {
    return this
        .toLowerCase()
        .split(' ')
        .map((palavra) => palavra.capitalize())
        .join(' ');
  }
}