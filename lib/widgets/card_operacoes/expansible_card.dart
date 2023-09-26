part of 'card_monitor_operacoes.dart';

class _FooterExpansible extends StatefulWidget {
  final bool isExpansible;
  final VoidCallback onToggle;

  const _FooterExpansible(
      {super.key, required this.isExpansible, required this.onToggle});

  @override
  State<_FooterExpansible> createState() => _FooterExpansibleState();
}

class _FooterExpansibleState extends State<_FooterExpansible> {
  @override
  Widget build(BuildContext context) {
    return widget.isExpansible
        ? Container(
            decoration: const BoxDecoration(
                color: Color(0xffFAFAFA),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(5))),
            child: TextButton(
              onPressed: widget.onToggle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mais Detalhes',
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: const BoxDecoration(
                color: Color(0xffFAFAFA),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Assinaturas Pendentes',
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          Modular.to
                              .pushNamed(AppRoutes.assinaturaDigitalRoute);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 4)),
                        child: Text(
                          'Ver Assinaturas',
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 11),
                        )),
                  )
                ],
              ),
            ));
  }
}
