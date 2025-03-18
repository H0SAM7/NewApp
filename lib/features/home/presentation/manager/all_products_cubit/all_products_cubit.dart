import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/data/home_repo/home_repo_impl.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(AllProductsInitial());

  Future<void> getAllProducts() async {
    emit(AllProductLoading());
    var result = await HomeRepoImp().getAllProducts();
    result.fold((failure) => emit(AllProductsFailure(errMessage: failure.errMessage!)),
        (products) => emit(AllProductsSuccess(products: products)));
  }
}
