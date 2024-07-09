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
      height: 150.h,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: onTap,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(icone, color: ambiente.IconColor, width: 60.w,),
                    Visibility(
                      visible: notificacoes >= 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15.r,
                          child: Text(
                            notificacoes > 9 ? '9+' : notificacoes.toString(),
                            style: context.textTheme.displaySmall!.copyWith(
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
                  style: context.textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
