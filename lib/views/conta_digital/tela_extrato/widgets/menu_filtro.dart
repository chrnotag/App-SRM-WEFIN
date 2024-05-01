part of '../tela_extrato.dart';

class _MenuFiltroTelaExtrato extends StatefulWidget {
  const _MenuFiltroTelaExtrato({super.key});

  @override
  State<_MenuFiltroTelaExtrato> createState() => _MenuFiltroTelaExtratoState();
}

class _MenuFiltroTelaExtratoState extends State<_MenuFiltroTelaExtrato> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: Text(
              'Movimentações',
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w900, color: Color(0XFF696969)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ItemMenuFiltro(quantidadeDias: 7),
              _ItemMenuFiltro(quantidadeDias: 15),
              _ItemMenuFiltro(quantidadeDias: 30),
              Icon(
                Icons.calendar_month,
                color: AppColors.azul,
                size: 45.r,
              ),
              Image.asset(
                Assets.imagesIconePdf,
                color: AppColors.azul,
                scale: 0.9,
              )
            ],
          )
        ],
      ),
    );
  }
}
