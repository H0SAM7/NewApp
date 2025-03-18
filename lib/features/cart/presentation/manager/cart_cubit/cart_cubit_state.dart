part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class AddCartSuccess extends CartState {}

final class AddCartLoading extends CartState {}

final class AddCartFailure extends CartState {
  final String errorMessage;

  AddCartFailure({required this.errorMessage});
}

final class FeachAllItemsSuccess extends CartState {}

final class FeachAllItemsFailure extends CartState {}
