import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';

import '../generated/assets.dart';

class SelecaoEmpresa extends StatelessWidget {
  final String nomeEmpresa;
  final String label;
  final bool changeble;
  final VoidCallback? onTap;

  const SelecaoEmpresa(
      {super.key,
      required this.nomeEmpresa,
      this.label = '',
      this.changeble = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: label.isNotEmpty,
          child: Text(
            label,
            style: context.textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white, width: 0.5, strokeAlign: 1),
                borderRadius: BorderRadius.circular(30)),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        nomeEmpresa,
                        style: context.textTheme.bodySmall!
                            .copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: changeble,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          Assets.iconsIcChangeCnpj,
                          color: Colors.white,
                          width: 15,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
