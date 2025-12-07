abstract class LoginState {
  final String email;
  final String password;

  LoginState({
    required this.email,
    required this.password,
  });
}

class LoginInitial extends LoginState {
  LoginInitial() : super(email: '', password: '');
}

class LoginFieldUpdated extends LoginState {
  LoginFieldUpdated({
    required super.email,
    required super.password,
  });
}
