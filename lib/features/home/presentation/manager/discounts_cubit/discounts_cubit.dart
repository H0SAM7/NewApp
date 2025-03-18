import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:my_visitor/features/admins/data/models/discount_model.dart';
import 'package:my_visitor/features/home/data/home_repo/home_repo_impl.dart';

part 'discounts_state.dart';

class DiscountsCubit extends Cubit<DiscountsState> {
  DiscountsCubit() : super(DiscountsInitial());
  Future<void> getAllDiscounts() async {
    emit(DiscountsLoading());
    var result = await HomeRepoImp().getAllDiscounts();
    result.fold(
        (failure) => emit(DiscountsFailure(errMessage: failure.errMessage!)),
        (discounts) => emit(DiscountsSuccess(discounts: discounts)));
  }
}
