class CalcularUltimoDiaMes {
  static DateTime resultado(DateTime data) {
    DateTime primeiroDiaDoMes = DateTime(data.year, data.month, 1);
    DateTime primeiroDiaDoProximoMes = DateTime(primeiroDiaDoMes.year, primeiroDiaDoMes.month + 1, 1);
    DateTime ultimoDiaDoMes = primeiroDiaDoProximoMes.subtract(Duration(days: 1));
    return ultimoDiaDoMes;
  }
}
