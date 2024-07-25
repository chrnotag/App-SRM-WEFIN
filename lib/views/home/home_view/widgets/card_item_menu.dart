part of '../home_view.dart';

class _CardItemMenuHome extends StatelessWidget {
  final String icone;
  final String titulo;
  final VoidCallback onTap;
  final int notificacoes;

  const _CardItemMenuHome({
    super.key,
    required this.icone,
    required this.titulo,
    this.notificacoes = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ambiente = Modular.get<Environment>();
    return SizedBox(
      width: 190.w,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: onTap,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: SvgPicture.asset(icone, color: ambiente.IconColor,),
                    ),
                    Visibility(
                      visible: notificacoes >= 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10.r,
                          child: Text(
                            notificacoes > 9 ? '9+' : notificacoes.toString(),
                            style: context.textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  titulo,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w900, color: SRMColors.textBodyColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
