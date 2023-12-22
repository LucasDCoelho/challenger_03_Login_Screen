import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_3/src/data/store/form_store/form_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: "/login");
  // final authStore = AuthStore();

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final formStore = Modular.get<FormStore>();

    final checkToken = await formStore.checkToken();
    final isUserAuthenticated = formStore.isTokenValid;

    if(checkToken && isUserAuthenticated){
       print("Token: $isUserAuthenticated");
      return isUserAuthenticated;
    }

    print("Token: $isUserAuthenticated");
    return isUserAuthenticated;
  }
}

