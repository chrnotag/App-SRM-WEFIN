part of '../selecionar_certificado.dart';

class PopUpDeletarCertificado {

  BuildContext context;
  PKCertificate certificado;
  String? title;
  String? label;
  PopUpDeletarCertificado({required this.context, required this.certificado, this.label, this.title});

  Widget get popUp {
    final CertificadoProvider certificadoProvider =
        Modular.get<CertificadoProvider>();
    return AlertDialog(
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              'Excluir',
              style: context.textTheme.bodyMedium
            ),
          ),
          Text(
            label ?? 'Você tem certeza que deseja excluir o certifcado?',
            style: context.textTheme.bodySmall,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: () {
                      certificadoProvider.deletarCertificado(certificado.thumbprint);
                      certificadoProvider.certificadoAtual = null;
                      Fluttertoast.showToast(
                          msg: 'Certificado removido com sucesso');
                      Modular.to.pop();
                    },
                    label: "Confirmar",
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BotaoPadrao(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  label: "Cancelar",
                  filled: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
