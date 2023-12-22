import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project_3/src/data/services/auth/auth_services.dart';
import 'package:project_3/src/widgets/drawer_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authService.getToken(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            String? token = snapshot.data;

             Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

            return Scaffold(
              drawer: CustomDrawer(decodedToken: decodedToken,),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: SizedBox(
              width: 350,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text("Card Information", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  const Divider(
                    height: 3,
                    color: Colors.black,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: NetworkImage(decodedToken['image'], scale: 2)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text("ID: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${decodedToken['id']}")
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Email: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${decodedToken['email']}")
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Username: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${decodedToken['username']}")
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Nome: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${decodedToken['firstName']}")
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Sobrenome: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${decodedToken['lastName']}")
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Genêro: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${decodedToken['gender']}")
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
                  ],
                )),
              );
          } else {
            // O token é nulo
            // Lide com o caso em que o token não está disponível
            return const Scaffold(
              body: Center(
                child: Text("Token não disponível."),
              ),
            );
          }
        } else {
          // O Future ainda não está concluído
          // Pode exibir um indicador de carregamento se necessário
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}