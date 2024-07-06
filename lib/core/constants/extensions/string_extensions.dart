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
    if (this.length == 11) {
      // Se o tamanho for 11, é CPF
      return '${this.substring(0, 3)}.${this.substring(3, 6)}.${this.substring(6, 9)}-${this.substring(9)}';
    } else if (this.length == 14) {
      // Se o tamanho for 14, é CNPJ
      return '${this.substring(0, 2)}.${this.substring(2, 5)}.${this.substring(5, 8)}/${this.substring(8, 12)}-${this.substring(12)}';
    } else {
      // Se o tamanho for diferente de 11 ou 14, não é um CPF nem CNPJ válido
      return 'Documento inválido';
    }
  }
}