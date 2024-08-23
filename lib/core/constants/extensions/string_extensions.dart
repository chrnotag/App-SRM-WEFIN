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

  String formatarDocumento() {
    switch (this.length) {
      case 11:
        return '${this.substring(0, 3)}.${this.substring(3, 6)}.${this.substring(6, 9)}-${this.substring(9)}';
      case 14:
        return '${this.substring(0, 2)}.${this.substring(2, 5)}.${this.substring(5, 8)}/${this.substring(8, 12)}-${this.substring(12)}';
      default:
        return this;
    }
  }

  String get digitoConta => '${this.substring(0, this.length -1)}-${this.substring(this.length - 1)}';

  String get iniciais {
    if (isEmpty) return '';
    List<String> palavras = trim().split(' ');
    if (palavras.isEmpty) return '';

    String primeiraInicial = palavras[0].substring(0, 1).toUpperCase();
    String segundaInicial = palavras.length > 1
        ? palavras[1].substring(0, 1).toUpperCase()
        : '';

    return primeiraInicial + segundaInicial;
  }

  String get primeirasDuasPalavras {
    if (isEmpty) return '';
    List<String> palavras = trim().split(' ');
    if (palavras.length < 2) {
      return this;
    } else {
      return '${palavras[0]} ${palavras[1]}';
    }
  }

}