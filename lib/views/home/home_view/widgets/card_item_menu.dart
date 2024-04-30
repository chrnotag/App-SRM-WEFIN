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
      width: 135.w,
      height: 120.h,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: onTap,
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(icone, color: ambiente.IconColor, width: 35.w,),
                    Visibility(
                      visible: notificacoes >= 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 12.r,
                        child: Text(
                          notificacoes > 9 ? '9+' : notificacoes.toString(),
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  titulo,
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
