part of 'register_cubit.dart';


@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccessful extends RegisterState {
  UserDataResponse registerResponse;
  RegisterSuccessful(this.registerResponse);
}
class RegisterError extends RegisterState {}
class UploadImageSuccessful extends RegisterState {}