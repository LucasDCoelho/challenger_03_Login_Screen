import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_3/src/app_widget.dart';
import 'package:project_3/src/screens/home_screen.dart';
import 'package:project_3/src/screens/login_screen.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget(),));
}

class AppModule extends Module {

  @override
  void binds(i){

  }

  @override
  void routes(r){
    r.child("/", child: (context) => const HomeScreen());
  }
}