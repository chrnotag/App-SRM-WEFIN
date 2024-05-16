import 'package:Srm_Asset/core/constants/enuns/tipo_operacao_enum.dart';

enum CodigosExtratoEnum {
  EFT(TipoTED.RECEBIMENTO_TED),
  DEV(TipoTED.RECEBIMENTO_TED),
  TEDC(TipoTED.RECEBIMENTO_TED),
  TEDD(TipoTED.ENVIO_TED),
  TARTED(TipoTED.ENVIO_TED),
  ENV(TipoTED.ENVIO_TED),
  TID(TipoTED.ENVIO_TED);

  final TipoTED tipoTed;
  const CodigosExtratoEnum(this.tipoTed);

}
