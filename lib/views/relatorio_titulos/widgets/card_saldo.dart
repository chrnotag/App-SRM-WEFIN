part of '../relatorio_titulos_screen.dart';

class _CardSaldo extends StatefulWidget {
  final bool isVencido;
  final double valor;

  const _CardSaldo({super.key, this.isVencido = false, required this.valor});

  @override
  State<_CardSaldo> createState() => _CardSaldoState();
}

class _CardSaldoState extends State<_CardSaldo> {
  Color? corFundo;
  Color? corTexto;
  bool isVisivel = false;

  void definirCor() {
    if (widget.isVencido) {
      corFundo = Color(0xffF9EEEE);
      corTexto = Color(0xffe6492d);
    } else {
      corFundo = Color(0xffE0EEFC);
      corTexto = Color(0xff0e6dfe);
    }
  }

  @override
  Widget build(BuildContext context) {
    definirCor();
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: corFundo!,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 widget.isVencido ? 'Saldo vencido' : 'Saldo a vencer',
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: corTexto, fontWeight: FontWeight.w100, fontSize: 12.sp),
                ),
                Row(
                  children: [
                    Text(
                      isVisivel
                          ? UtilBrasilFields.obterReal(widget.valor)
                          : 'R\$ ****',
                      style: context.textTheme.displaySmall!
                          .copyWith(color: corTexto, fontWeight: FontWeight.w900, fontSize: 16.sp),
                    ),
                    SizedBox(width: 20.w,),
                    InkWell(
                        onTap: () => setState(() {
                          isVisivel = !isVisivel;
                        }),
                        child: isVisivel
                            ? Icon(Icons.visibility, color: corTexto,)
                            : Icon(Icons.visibility_off, color: corTexto,)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
