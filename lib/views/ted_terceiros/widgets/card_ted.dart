part of '../lista_ted_screen/lista_teds_aprovacao_screen.dart';

class _CardTedTerceiros extends StatelessWidget {
  const _CardTedTerceiros({super.key});

  @override
  Widget build(BuildContext context) {
    final statusTed = TedTerceirosEnum.fromStatus('N');
    return SizedBox(
      height: statusTed.botoes == null ? 250.h : 300.h,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ItemCardTed(
                  title: 'Favorecido', content: 'Marcelo Neves Teixeira'),
              _ItemCardTed(title: 'CPF/CNPJ', content: '602.115.253-83'),
              _ItemCardTed(title: 'Valor', content: 'R\$ 1.325,69 '),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status'),
                  Container(
                    decoration: BoxDecoration(
                      color: statusTed.corFundo,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.r),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      child: Text(
                        statusTed.status,
                        style: context.textTheme.bodyLarge!.copyWith(
                            color: statusTed.corTexto,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [statusTed.botoes ?? Container()],
              )
            ],
          ),
        ),
      ),
    );
  }
}
