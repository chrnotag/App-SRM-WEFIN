part of '../../menu_user/menu.dart';

class PopUpDeslogarApp {
  BuildContext context;
  AuthProvider authProvider;

  PopUpDeslogarApp({required this.context, required this.authProvider});

  Widget get popUp {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            LineIcons.exclamationCircle,
            color: context.primaryColor,
            size: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Atenção',
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 1.5,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Deseja encerrar o aplicativo?',
                style: context.textTheme.labelSmall!
                    .copyWith(color: AppColors.labelText)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: () {
                      DeslogarUsuario().deslogar();
                    },
                    label: 'SAIR',
                  ),
                )
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
                    label: 'CANCELAR',
                filled: false,),
              )
            ],
          )
        ],
      ),
    );
  }
}
