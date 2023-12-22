import "dart:async";

import "package:mobx/mobx.dart";
import "package:project_3/src/data/services/auth/auth_services.dart";
import "package:project_3/src/data/store/exceptions/form_exception.dart";

part "form_store.g.dart";

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final AuthService authService = AuthService();

 @observable
  FormExceptionState errorForm = FormExceptionState();

  @observable
  String username = "";

  @observable
  String password = "";

  @observable
  bool isTokenValid = false;

  @computed
  bool get canLogin => !errorForm.hasErrors;
  
  late List<ReactionDisposer> _disposers;


  void setupValidations() {
    _disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  void validateUsername(String value) {
    errorForm.username = value.isEmpty ? "O campo de username não pode ficar em branco" : null;
  }

  @action
  void validatePassword(String value) {
    errorForm.password = value.isEmpty ? "O campo de senha não pode ficar em branco" : null;
  }

  @action
  Future<bool> logout() async{
    final isLogout = await authService.logout();
    if(isLogout == false) {
      return isTokenValid = false;
    }
    return isTokenValid;
  }

  @action
  Future<bool> login() async {
    // Assuming you're using async/await for login process
    final String? token = await authService.login(
      username: username,
      password: password,
    );

    if (token != null) {
      return isTokenValid = true;
    } else {
      return isTokenValid = false;
      // Handle login failure, update errorForm or show an error message
    }
  }

  @action
  Future<bool> checkToken() async {
    final String? token = await authService.getToken();

    if (token != null) {
      print(token);
      return isTokenValid = true;
    } else {
      return isTokenValid = false;
    }
  }
  void disposer() {
    for (final dispose in _disposers) {
      dispose();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUsername(username);
  }
}
