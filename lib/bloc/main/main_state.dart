part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class CurrentIndexChanged extends MainState {}
class GetHomeDataLoading extends MainState {}
class GetHomeDataSuccessful extends MainState {}
class GetHomeDataError extends MainState {}
class GetCategoriesLoading extends MainState {}
class GetCategoriesSuccessful extends MainState {}
class GetCategoriesError extends MainState {}
class ChangeFavouriteProductLoading extends MainState {}
class ChangeFavouriteProductSuccessful extends MainState {}
class ChangeFavouriteProductError extends MainState {}
class GetFavouritesLoading extends MainState {}
class GetFavouritesSuccessful extends MainState {}
class GetFavouritesError extends MainState {}
class GetCategoryProductsLoading extends MainState {}
class GetCategoryProductsSuccessful extends MainState {}
class GetCategoryProductsError extends MainState {}
class SearchInitial extends MainState {}
class SearchProductLoading extends MainState {}
class SearchProductSuccessful extends MainState {}
class SearchProductError extends MainState {}
class ChangeCartProductLoading extends MainState {}
class ChangeCartProductSuccessful extends MainState {}
class ChangeCartProductError extends MainState {}