part of '../transferencias_screen.dart';

class _ListaFavoritos extends StatefulWidget {
  const _ListaFavoritos({super.key});

  @override
  State<_ListaFavoritos> createState() => _ListaFavoritosState();
}

class _ListaFavoritosState extends State<_ListaFavoritos> {
  final favoritosProvider = Modular.get<BeneficiariosRecentesProvider>();

  @override
  void initState() {
    super.initState();
    favoritosProvider.futureDados = favoritosProvider.carregarBeneficiariosRecentes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
          child: Text(
            'Recentes e favoritos',
            style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w900, color: SRMColors.textBodyColor),
          ),
        ),
        Container(
          height: 186.h,
          width: context.width,
          color: Colors.white,
          child: FutureBuilder(
            future: favoritosProvider.futureDados,
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Loader();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: Text(
                      'Transferências Recentes',
                      style: context.textTheme.bodyLarge!.copyWith(color: context.labelTextColor),
                    ),
                  ),
                  SizedBox(
                    height: 160.h,
                    child: ListView.builder(
                      itemCount: favoritosProvider.listaBeneficiarios.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 80.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffEEEEEE),
                                border: Border.all(color: context.primaryColor),
                              ),
                              child: Center(
                                child: Text(
                                  favoritosProvider.listaBeneficiarios[index].nomeBeneficiario.iniciais.toUpperCase(),
                                  style: context.textTheme.displaySmall!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: SRMColors.textBodyColor,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              favoritosProvider.listaBeneficiarios[index].nomeBeneficiario.primeirasDuasPalavras.capitalizeCadaPalavra(),
                              style: context.textTheme.bodyLarge,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                favoritosProvider.listaBeneficiarios[index].favorito ?
                                Icons.star : Icons.star_border,
                                color: context.primaryColor,
                                size: 35.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
