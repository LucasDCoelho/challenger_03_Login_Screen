import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "My login app",
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 39, 62, 194)),
      routerConfig: Modular.routerConfig,
    );
  }
}
