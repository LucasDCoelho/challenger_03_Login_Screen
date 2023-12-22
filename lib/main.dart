import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_3/app_widget.dart';
import 'package:project_3/auth_guard.dart';
import 'package:project_3/src/data/store/form_store/form_store.dart';
import 'package:project_3/src/screens/home_screen.dart';
import 'package:project_3/src/screens/login_screen.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget(),));
}

class AppModule extends Module {
  @override
  void binds(i){
    i.addLazySingleton(FormStore.new);
  }

  @override
  void routes(r){
    r.child("/", child: (context) => const HomeScreen(), guards: [AuthGuard()]);
    r.child('/login', child: (context) => const LoginScreen());
  }
}