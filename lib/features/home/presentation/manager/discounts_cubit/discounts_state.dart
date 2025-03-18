part of 'discounts_cubit.dart';

@immutable
sealed class DiscountsState {}

final class DiscountsInitial extends DiscountsState {}

final class DiscountsSuccess extends DiscountsState {
  final List<DiscountModel> discounts;

  DiscountsSuccess({required this.discounts});
}

final class DiscountsLoading extends DiscountsState {}

final class DiscountsFailure extends DiscountsState {
  final String errMessage;

  DiscountsFailure({required this.errMessage});
}
