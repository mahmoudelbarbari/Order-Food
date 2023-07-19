import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/domain/reporisatory/restaurant_reporisatory.dart';

class GetAllMenuUsecase {
  final RestaurantReporisatory restaurantReporisatory;
  GetAllMenuUsecase(this.restaurantReporisatory);

  Future<List<MenuModel>> call() async {
    return await restaurantReporisatory.getAllMenu();
  }
}
