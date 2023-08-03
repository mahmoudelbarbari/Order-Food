import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/cart/domain/usecase/add_items_to_cart_usecase.dart';
import 'package:order/features/cart/domain/usecase/get_all_cart_items_usecase.dart';
import 'package:order/features/cart/presentation/cubit/cart_state.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/injection_container.dart';

class CartCubit extends Cubit<CartState> {
  late AddProductToCartUsecase addProductToCartUsecase;
  late GetAllCartItemsUsecase getAllCartItemsUsecase;

  CartCubit() : super(CartLoading());

  Future<void> addProductToCart(MenuModel menuModel) async {
    try {
      addProductToCartUsecase = sl();
      final addedCartItem = await addProductToCartUsecase.call(menuModel);
      if (addedCartItem.status) {
        emit(CartSuccess(addedCartItem));
      } else {
        emit(CartError(errorMessage: addedCartItem.message));
      }
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }

  Future<void> getAllCartItems() async {
    try {
      emit(CartLoading());
      getAllCartItemsUsecase = sl();
      final allCartItems = await getAllCartItemsUsecase.call();
      emit(CartItemsLoadded(menuModel: allCartItems));
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }
}
