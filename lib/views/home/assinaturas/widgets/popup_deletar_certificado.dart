part of '../selecionar_certificado.dart';

class PopUpDeletarCertificado {

  BuildContext context;
  ImportarCertificadoProvider certificadoProvider;
  int index;

  PopUpDeletarCertificado(
      {required this.context, required this.certificadoProvider, required this.index});

  Widget get popUp {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return AlertDialog(
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Excluir',
              style: context.textTheme.bodyMedium!.copyWith(
                color: isTemaSRM
                    ? AppColors.corPrimariaSRM
                    : context.shadersTrust[900],
              ),
            ),
          ),
          Text(
            'Você tem certeza que deseja excluir o certifcado?',
            style: context.textTheme.bodySmall,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: WefinDefaultButton(
                      onPressed: () {
                        certificadoProvider.deletarCertificado(
                            certificadoProvider
                                .listaCertificados[index].thumbprint);
                        Modular.to.pop();
                      },
                      label: "Confirmar",),
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