import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';

import '../generated/assets.dart';

class SelecaoEmpresa extends StatelessWidget {
  final String nomeEmpresa;
  final String tituloPagina;
  final bool changeble;

  const SelecaoEmpresa({
    super.key,
    required this.nomeEmpresa,
    this.tituloPagina = '',
    this.changeble = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Visibility(
            visible: tituloPagina.isNotEmpty,
            child: Text(
              tituloPagina,
              style: context.textTheme.bodyMedium!.copyWith(
                  color: context.onSecondary,
                  fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: context.width * 0.5,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          context.onSecondary,
                      width: 0.5.w,
                      strokeAlign: 1),
                  borderRadius: BorderRadius.circular(30.r)),
              child: InkWell(
                onTap: changeble
                    ? () =>
                        Modular.to.navigate(AppRoutes.listaSelecaoEmpresasRoute)
                    : () {},
                borderRadius: BorderRadius.circular(30.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.0.w, vertical: 2.h),
                      child: SizedBox(
                        width: context.width * 0.4,
                        child: Text(
                          nomeEmpresa,
                          style: context.textTheme.bodySmall!.copyWith(
                              color: context.onSecondary),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: changeble,
                      child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: SvgPicture.asset(
                            Assets.iconsIcChangeCnpj,
                            color: context.onSecondary,
                            width: 15.w,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
