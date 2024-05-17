part of '../tela_extrato.dart';

class _ItemListaExtrato extends StatelessWidget {
  final String dataDia;
  final String saldoDia;

  const _ItemListaExtrato({
    super.key,
    required this.dataDia,
    required this.saldoDia,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(FormatarData.formatarExtenso(DateTime.parse(dataDia)), style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900, color: AppColors.labelText),),
      subtitle: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Saldo do dia:'),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
                    ),
                    color: Colors.grey.shade300
                  ),
                  child: Text(
                    saldoDia,
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
          Divider(color: AppColors.labelText, thickness: 0.2)
        ],
      ),
    );
  }
}
