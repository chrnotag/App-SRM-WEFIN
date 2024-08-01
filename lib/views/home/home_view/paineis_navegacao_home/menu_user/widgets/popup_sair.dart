part of '../menu.dart';

class PopUpDeslogarApp {
  BuildContext context;
  AuthProvider authProvider;

  PopUpDeslogarApp({required this.context, required this.authProvider});

  Widget get popUp {
    return AlertDialog(
      title: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Icon(
              LineIcons.exclamationCircle,
              color: context.focusColor,
              size: 137.r,
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Text('Atenção',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    letterSpacing: 1.5.sp,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Text('Deseja encerrar o aplicativo?',
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: context.labelTextColor)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: Row(
                children: [
                  Expanded(
                    child: BotaoPadrao(
                      onPressed: () {
                        DeslogarUsuario(context: context).encerrarSessao();
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
      ),
    );
  }
}
