enum TipoContaEnum{
  CC('Conta Corrente'),
  CP('Conta Poupança');

  final String tipoConta;
  const TipoContaEnum(this.tipoConta);

  static String traduzir(String tipoConta){
    if(tipoConta == TipoContaEnum.CC.tipoConta){
      return 'CC';
    }else{
      return 'CP';
    }
  }
}