import 'package:flutter/material.dart';
import 'package:project_3/src/data/services/auth/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Digite seu username",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Digite sua senha",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite uma senha';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                _authService.login(
                  username: _usernameController.value.text, 
                  password: _passwordController.value.text
                  );
                print("Deu certo!");
              }
            }, child: const Text("Entrar")
            ),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                _authService.logout();
                 print("Logout");
              }
             
            }, child: const Text("Sair")
            )
          ],
        ),
      )),
    );
  }
}
