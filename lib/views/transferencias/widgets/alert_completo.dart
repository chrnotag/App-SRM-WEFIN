part of '../transferencias_screen.dart';

class _AlertTransferenciaFeita extends StatelessWidget {
  const _AlertTransferenciaFeita({super.key});

  @override
  Widget build(BuildContext context){
    final ambiente = Modular.get<Environment>();
    return AlertDialog(
      icon: SvgPicture.asset(ambiente.check_icone),
      title: SizedBox(
        height: context.height * 0.25,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'Transferência TED',
                  style: context.textTheme.displaySmall!.copyWith(
                      color: context.labelTextColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Sua solicitação de TED foi enviada com sucesso!',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            BotaoPadrao(
                label: 'Fechar',
                onPressed: () {
                  Modular.to.pop();
                  Modular.to.pop();
                })
          ],
        ),
      ),
    );
  }
}
