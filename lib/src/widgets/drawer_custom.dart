import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_3/src/data/store/form_store/form_store.dart';

class CustomDrawer extends StatefulWidget {
  final Map<String, dynamic> decodedToken;
  const CustomDrawer({required this.decodedToken, super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FormStore _formStore = FormStore();
  String selectedPage = "";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${widget.decodedToken['username']}"),
            accountEmail: Text("${widget.decodedToken['email']}"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network("${widget.decodedToken['image']}"),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                  ),
                ],
              ),
              Observer(
                  builder: (context) => ElevatedButton (
                      onPressed: () async {
                        await _formStore.logout();
                        if (_formStore.isTokenValid == false) {
                          Modular.to.navigate("/login");
                        }
                      },
                      child: const Text("Sair")))
            ],
          )
        ],
      ),
    );
  }
}
