part of '../transferencias_screen.dart';

class _ListaFavoritos extends StatefulWidget {
  const _ListaFavoritos({super.key});

  @override
  State<_ListaFavoritos> createState() => _ListaFavoritosState();
}

class _ListaFavoritosState extends State<_ListaFavoritos> {
  Future<void> teste() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: Text(
            'Recentes e favoritos',
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w900, color: SRMColors.textBodyColor),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 160.h,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 29.w),
                      child: Text('Transferencias Recentes', style: context.textTheme.bodyLarge,),
                    ),
                    FutureBuilder(
                      future: teste(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Loader();
                        }
                        return ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
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
                                      border:
                                          Border.all(color: context.primaryColor)),
                                  child: Center(
                                    child: Text(
                                    pegarIniciais(limitarTexto('nome teste inteiro')).toUpperCase(),
                                      style: context.textTheme.displaySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: SRMColors.textBodyColor),
                                    ),
                                  ),
                                ),
                                Text(
                                  limitarTexto('nome teste inteiro').capitalizeCadaPalavra(),
                    
                                  style: context.textTheme.bodyLarge,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.star,
                                      color: context.primaryColor,
                                      size: 35.r,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
  String limitarTexto(String texto) {
    List<String> palavras = texto.split(' ');

    if (palavras.length > 2) {
      return palavras.sublist(0, 2).join(' ');
    }

    return texto;
  }
  
  String pegarIniciais(String texto) {
    List<String> palavras = texto.split(' ');

    return palavras.map((palavra) => palavra[0]).join('');
  }

}
