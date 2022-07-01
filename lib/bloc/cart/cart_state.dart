part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class GetCartsLoading extends CartState {}
class GetCartsSuccessful extends CartState {}
class GetCartsError extends CartState {}
class DeleteCartsCartsLoading extends CartState {}
class DeleteCartsSuccessful extends CartState {}
class DeleteCartsError extends CartState {}
class UpdateCartLoading extends CartState {}
class UpdateCartSuccessful extends CartState {}
class UpdateCartError extends CartState {}