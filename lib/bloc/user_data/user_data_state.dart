part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}
class GetUserDataLoading extends UserDataState {}
class GetUserDataSuccessful extends UserDataState {}
class GetUserDataError extends UserDataState {}
class UpdateProfileLoading extends UserDataState {}
class UpdateProfileSuccessful extends UserDataState {}
class UpdateProfileError extends UserDataState {}
class UploadImageSuccessful extends UserDataState {}