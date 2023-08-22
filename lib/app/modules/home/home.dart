import 'package:flutter/material.dart';
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
    return const Scaffold(
      appBar: NavBar(),
      body: Center(
        child: Text('Hello, World! This is the home page.'),
      ),
    );
  }
}

void main() {
  runApp(const HomeApp());
}
