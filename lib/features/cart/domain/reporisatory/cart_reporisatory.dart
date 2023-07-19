import 'package:order/features/cart/data/models/cart_items_model.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

abstract class CartReporisatoryInterface {
  Future<BaseResponse> addProductToCart(MenuModel menuModel);
  Future<BaseResponse> addCartData(CartItemModel cartItemModel);
  Future<List<MenuModel>> getAllCartItems();
}
