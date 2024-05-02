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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _ItemMenuFiltro(quantidadeDias: 15),
              ),
              _ItemMenuFiltro(quantidadeDias: 30),
              IconButton(
                onPressed: () => Modular.to.pushNamed(AppRoutes.selecionarDataScreenRoute),
                icon: Icon(Icons.calendar_month, size: 45.r,),
                color: AppColors.azul,
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
