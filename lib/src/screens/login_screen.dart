import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_3/src/data/store/form_store/form_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FormStore _formStore = FormStore();

  @override
  void initState() {
    super.initState();
    _formStore.setupValidations();
  }

  void disposeState() {
    _formStore.disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
          child: Form(
        child: Column(
          children: <Widget>[
            Observer(
                builder: (context) => Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 10),
                      child: TextFormField(
                        onChanged: (value) => _formStore.username = value,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Username",
                            hintText: "Digite seu username",
                            errorText: _formStore.errorForm.username),
                      ),
                    )),
            Observer(
              builder: (context) => Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 30),
                child: TextFormField(
                  onChanged: (value) => _formStore.password = value,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Senha",
                      hintText: "Digite sua senha",
                      errorText: _formStore.errorForm.password),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 50),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    _formStore.validateAll();
                    if (_formStore.canLogin) {
                      await _formStore.login();
                      if (_formStore.isTokenValid) {
                        Modular.to.navigate("/");
                        print("Success");
                      }
                    }
                  },
                  child: const Text(
                    "Entrar",
                 )),
            ),
          ],
        ),
      )),
    );
  }
}
