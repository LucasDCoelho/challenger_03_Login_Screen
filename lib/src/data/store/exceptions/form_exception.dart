import 'package:mobx/mobx.dart';

part 'form_exception.g.dart';

class FormExceptionState = _FormExceptionState with _$FormExceptionState;

abstract class _FormExceptionState with Store {
  @observable
  String? username;

  @observable
  String? password;

  @computed
  bool get hasErrors => username != null || password != null;
}