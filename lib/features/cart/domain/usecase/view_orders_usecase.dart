import 'package:order/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

class ViewOrderUsecase {
  final CartReporisatoryInterface cartReporisatoryInterface;
  ViewOrderUsecase(this.cartReporisatoryInterface);

  Future<List<MenuModel>> call() async {
    return await cartReporisatoryInterface.viewOrders();
  }
}
