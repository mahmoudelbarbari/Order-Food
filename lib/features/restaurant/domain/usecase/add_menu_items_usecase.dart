import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/domain/reporisatory/restaurant_reporisatory.dart';

class AddMenuItemsUsecase {
  final RestaurantReporisatory restaurantReporisatory;
  AddMenuItemsUsecase(this.restaurantReporisatory);

  Future<BaseResponse> call(MenuModel menuModel) async {
    return await restaurantReporisatory.addMenuItems(menuModel);
  }
}
