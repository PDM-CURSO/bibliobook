part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  // mostrar splash screen
}

class AuthSuccessState extends AuthState {
  // mostrar home page
}

class SignOutSuccessState extends AuthState {
  // cerrar sesion
}

class AuthErrorState extends AuthState {
  // mosterar un error
  final String eMsg;

  AuthErrorState({this.eMsg = ""});
  @override
  List<Object> get props => [eMsg];
}

class AuthLoadingState extends AuthState {
  // para mostrar carga
}

class UnAuthState extends AuthState {
  // para mostrar el login
}
