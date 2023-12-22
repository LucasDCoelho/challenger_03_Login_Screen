import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_3/src/data/services/auth/auth_services.dart';
import 'package:project_3/src/data/store/form_store/form_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final FormStore _formStore = FormStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Home Screen"),
          Observer(
              builder: (context) => ElevatedButton(
                  onPressed: () async {
                      await _formStore.logout();
                      if(_formStore.isTokenValid == false){
                        Modular.to.navigate("/login");
                      }
                  },
                  child: const Text("Sair")))
        ],
      )),
    );
  }
}
