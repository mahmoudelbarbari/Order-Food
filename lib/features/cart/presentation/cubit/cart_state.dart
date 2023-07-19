import 'package:order/features/restaurant/data/model/restaurant_model.dart';

abstract class CartState {}

class CartStateInt extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  String errorMessage;
  CartError({required this.errorMessage});
}

class CartSuccess extends CartState {
  CartSuccess(addedCartItem);
}

class CartItemsLoadded extends CartState {
  final List<MenuModel> menuModel;
  CartItemsLoadded({
    required this.menuModel,
  });
}
