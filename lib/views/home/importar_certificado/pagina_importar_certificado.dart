import 'package:Srm_Asset/views/home/importar_certificado/widgets/molde_tela_tutorial_certificado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';

class PaginaImportarCertificado {
  static List<Widget> pagina(BuildContext context) {
    return [
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.primeiroSlideDispositivo,
        tituloPagina: 'Importe seu certificado via Dispositivo',
        descricaoPagina:
            'Bem-vindo ao assistente de importação de certificado digital. Nas proximas páginas será explicado como importar seu arquivo de certificado digital de seu aparelho móvel.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.segundoSlideDispositivo,
        tituloPagina: 'Selecione seu Certificado',
        descricaoPagina:
            'Após clicar no botão de importação, seu explorador de arquivos será aberto. Navegue até a localização do seu certificado digital.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.terceiroSlideDispositivo,
        tituloPagina: 'Localize seu Certificado',
        descricaoPagina:
            'Procure na lista de arquivos pelo seu certificado digital. Ele pode estar no formato .pfx, .p12, ou outro dependendo do seu dispositivo.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.quartoSlideDispositivo,
        tituloPagina: 'Selecionando o Certificado',
        descricaoPagina:
            'Uma vez que encontrar o arquivo do certificado, clique sobre ele para selecioná-lo. Será necessário informar a senha do certificado após isso',
      ),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.quintoSlideDispositivo,
        tituloPagina: 'Importação Concluída',
        descricaoPagina:
            'Após selecionar o arquivo, o certificado será importado automaticamente. Basta informar a senha e você estará pronto para utilizá-lo!',
        isTelaFinal: true,
      ),
    ];
  }
}
