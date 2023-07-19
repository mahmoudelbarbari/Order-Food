import 'package:order/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

class AddProductToCartUsecase {
  final CartReporisatoryInterface cartReporisatoryInterface;
  AddProductToCartUsecase(this.cartReporisatoryInterface);

  Future<BaseResponse> call(MenuModel menuModel) async {
    return await cartReporisatoryInterface.addProductToCart(menuModel);
  }
}
