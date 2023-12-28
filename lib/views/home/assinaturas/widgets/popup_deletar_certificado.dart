part of '../selecionar_certificado.dart';

class PopUpDeletarCertificado {
  BuildContext context;
  PKCertificate certificado;
  String? title;
  String? label;
  PopUpDeletarCertificado({required this.context, required this.certificado, this.label, this.title});

  Widget get popUp {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    final ImportarCertificadoProvider certificadoProvider =
        Modular.get<ImportarCertificadoProvider>();
    return AlertDialog(
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title ?? 'Excluir',
              style: context.textTheme.bodyMedium!.copyWith(
                color: isTemaSRM
                    ? AppColors.corPrimariaSRM
                    : context.shadersTrust[900],
              ),
            ),
          ),
          Text(
            label ?? 'Você tem certeza que deseja excluir o certifcado?',
            style: context.textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: WefinDefaultButton(
                    onPressed: () {
                      certificadoProvider.deletarCertificado(certificado.thumbprint);
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
                child: WefinDefaultButton(
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
