import 'package:order/features/cart/data/datasource/cart_datasource.dart';
import 'package:order/features/cart/data/models/cart_items_model.dart';
import 'package:order/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

class CartReporisatoryImpl implements CartReporisatoryInterface {
  final CartDatasourceInterface cartDatasourceInterface;
  CartReporisatoryImpl(this.cartDatasourceInterface);

  @override
  Future<BaseResponse> addProductToCart(MenuModel menuModel) async {
    return await cartDatasourceInterface.addProductToCart(menuModel);
  }

  @override
  Future<List<MenuModel>> getAllCartItems() async {
    return await cartDatasourceInterface.getAllCartItems();
  }

  @override
  Future<BaseResponse> addCartData(CartItemModel cartItemModel) {
    // TODO: implement addCartData
    throw UnimplementedError();
  }
}
