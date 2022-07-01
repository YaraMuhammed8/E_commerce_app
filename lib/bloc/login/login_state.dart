part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccessful extends LoginState {
  UserDataResponse loginResponse;
  LoginSuccessful(this.loginResponse);
}
class LoginError extends LoginState {}