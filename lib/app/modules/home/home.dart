import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';
import 'package:flutter_mobile_project/app/modules/home/widgets/contexto.dart';
import '../../core/ui/widgets/navbar.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/HomeApp',
      routes: {
        '/HomeApp': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: Container(
        color: AppColors.globalBackground,
        child: const Center(
          child: ContextoWidget(),
        ),
      ),
    );
  }
}

void main() {
  runApp(const HomeApp());
}
