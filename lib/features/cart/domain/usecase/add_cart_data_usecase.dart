import 'package:order/features/cart/data/models/cart_items_model.dart';
import 'package:order/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';

class AddCartData {
  final CartReporisatoryInterface cartReporisatoryInterface;
  AddCartData(this.cartReporisatoryInterface);

  Future<BaseResponse> call(CartItemModel cartItemModel) async {
    return await cartReporisatoryInterface.addCartData(cartItemModel);
  }
}
