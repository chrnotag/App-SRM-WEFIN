import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ambiente = Modular.get<Environment>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.secondaryColor,
      body: Column(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                ambiente.logo,
                width: context.width * 0.5,
              ),
              SizedBox(
                height: 30.h,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
