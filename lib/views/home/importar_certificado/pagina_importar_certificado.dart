import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/widgets/molde_tela_tutorial_certificado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/certificado_provider/certificado_provider.dart';
import '../../../widgets/dialog_senha_certificado.dart';
import '../../../widgets/wefin_patterns/wefin_default_button.dart';

class PaginaImportarCertificado {
  static List<Widget> pagina(BuildContext context) {
    return const [
      MoldeTutorialCertificado(
        imagemSvg: Assets.importe_certificado_svg,
        tituloPagina: 'Importe seu certificado via Dispositivo',
        descricaoPagina:
            'Bem-vindo ao assistente de importação de certificado digital. Nas proximas páginas será explicado como importar seu arquivo de certificado digital de seu aparelho móvel.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: Assets.selecionar_certificado_svg,
        tituloPagina: 'Selecione seu Certificado',
        descricaoPagina:
            'Após clicar no botão de importação, seu explorador de arquivos será aberto. Navegue até a localização do seu certificado digital.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: Assets.localizar_cetificado_svg,
        tituloPagina: 'Localize seu Certificado',
        descricaoPagina:
            'Procure na lista de arquivos pelo seu certificado digital. Ele pode estar no formato .pfx, .p12, ou outro dependendo do seu dispositivo.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: Assets.informe_senha_certificado_svg,
        tituloPagina: 'Selecionando o Certificado',
        descricaoPagina:
            'Uma vez que encontrar o arquivo do certificado, clique sobre ele para selecioná-lo. Será necessário informar a senha do certificado após isso',
      ),
      MoldeTutorialCertificado(
        imagemSvg: Assets.importacao_concluida_svg,
        tituloPagina: 'Importação Concluída',
        descricaoPagina:
            'Após selecionar o arquivo, o certificado será importado automaticamente. Basta informar a senha e você estará pronto para utilizá-lo!',
        isTelaFinal: true,
      ),
    ];
  }
}
