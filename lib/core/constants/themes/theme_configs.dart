import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';

class AppColors {
  static const Color azul = Color(0xFF1E3870);
  static const Color azulPrimarioSRM = Color(0xFF5B95CC);
  static const Color laranjaSRM = Color(0xFFF18820);
  static const Color verdePrimarioTRUST = Color(0xFF0EAC58);
  static const Color labelText = Color(0xFF8A8A8A);
  static const Color cinzaEscuro = Color(0xff838383);
  static const Color branco = Color(0xFFFFFFFF);
  static const Color laranja = Color(0xFFF29046);
  static const Color vermelho = Color(0xFFA74D4D);
  static const Color verde = Color(0xFF84B38A);
  static const Color brancoGelo = Color(0xFFECECEC);
}

class AppSizes {
  static const double paddingSmall = 8;
  static const double paddingLigth = 14;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;
  static const double paddingExtraLarge = 32;

  double bodySmall = 10.sp;
  double bodyMedium = 14.sp;
  double bodyLarge = 16.sp;
  double labelMedium = 12.sp;
  double displaySmall = 18.sp;
  double displayMedium = 22.sp;
  double displayLarge = 24.sp;
}

class BorderRadiusBotaoEnvio {
  static const double borderRadius = 4;
}

class TrustShades {
  static const primaryColor = <int, Color>{
    50: Color(0xFFE8F5EC), // Verde (50)
    100: Color(0xFFC4E6CF), // Verde (100)
    200: Color(0xFF9FD7B1), // Verde (200)
    300: Color(0xFF7BC893), // Verde (300)
    400: Color(0xFF56B975), // Verde (400)
    500: Color(0xFF0EAC58), // Verde Primário (500)
    600: Color(0xFF0C994F), // Verde (600)
    700: Color(0xFF0A8645), // Verde (700)
    800: Color(0xFF08733C), // Verde (800)
    900: Color(0xFF065F32), // Verde (900)
  };
}

class SRMShaders {
  static const primaryColor = <int, Color>{
    50: Color(0xFFE1E8F4), // Azul (50)
    100: Color(0xFFB4C3E0), // Azul (100)
    200: Color(0xFF879ECB), // Azul (200)
    300: Color(0xFF5A79B7), // Azul (300)
    400: Color(0xFF2D549E), // Azul (400)
    500: Color(0xFF05204F), // Azul Primário (500)
    600: Color(0xFF041C46), // Azul (600)
    700: Color(0xFF03183D), // Azul (700)
    800: Color(0xFF021433), // Azul (800)
    900: Color(0xFF010B1A), // Azul (900)
  };
}
