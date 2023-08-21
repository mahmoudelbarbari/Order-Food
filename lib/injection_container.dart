import 'package:get_it/get_it.dart';
import 'package:order/core/database/firebase_db.dart';
import 'package:order/features/cart/data/datasource/cart_datasource.dart';
import 'package:order/features/cart/data/reporisatory_imlp/cart_reporisatory_impl.dart';
import 'package:order/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:order/features/cart/domain/usecase/add_items_to_cart_usecase.dart';
import 'package:order/features/cart/domain/usecase/clear_cart_items_usecase.dart';
import 'package:order/features/cart/domain/usecase/get_all_cart_items_usecase.dart';
import 'package:order/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:order/features/event/data/datasource/remote_ticket_datasource.dart';
import 'package:order/features/event/data/reporisatory/remote_ticket_reporisatory_impl.dart';
import 'package:order/features/event/domain/remote_usecases/add_ticket.dart';
import 'package:order/features/event/domain/remote_usecases/delete_ticket.dart';
import 'package:order/features/event/domain/remote_usecases/get_messages_usecase.dart';
import 'package:order/features/event/domain/remote_usecases/message_usecase.dart';
import 'package:order/features/event/domain/remote_usecases/remote_get_all_ticket.dart';
import 'package:order/features/event/domain/remote_usecases/update_ticket.dart';
import 'package:order/features/event/domain/reporisatory/ticket_reporisatory.dart';
import 'package:order/features/event/presentation/cubit/cubit_message/chat_cubit.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/login/data/datasources/remote_login_user.dart';
import 'package:order/features/login/domain/usecases/remote_login_usecase.dart';
import 'package:order/features/login/domain/usecases/remote_logout_usecase.dart';
import 'package:order/features/login/presentation/cubit/login_cubit.dart';
import 'package:order/features/register/data/datasource/remote_register_user_datasource.dart';
import 'package:order/features/register/data/reporisatory/register_reporisatory_impl.dart';
import 'package:order/features/register/domain/reposisatory/register_reprisatory.dart';
import 'package:order/features/register/domain/usecase/get_user_info_usecase.dart';
import 'package:order/features/register/domain/usecase/remote_register_usecase.dart';
import 'package:order/features/register/presentation/cubit/register_cubit.dart';
import 'package:order/features/restaurant/data/datasource/restaurant_datasource.dart';
import 'package:order/features/restaurant/data/reporisatory/restaurant_reporisatory_impl.dart';
import 'package:order/features/restaurant/domain/reporisatory/restaurant_reporisatory.dart';
import 'package:order/features/restaurant/domain/usecase/add_menu_items_usecase.dart';
import 'package:order/features/restaurant/domain/usecase/add_restaurant_usecase.dart';
import 'package:order/features/restaurant/domain/usecase/get_all_menu.dart';
import 'package:order/features/restaurant/domain/usecase/get_all_restaurant_usecase.dart';
import 'package:order/features/restaurant/domain/usecase/get_uploaded_iamge_usecase.dart';
import 'package:order/features/restaurant/domain/usecase/upload_image_usecase.dart';
import 'package:order/features/restaurant/presentation/cubit/menu_cubit.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';

import 'features/cart/domain/usecase/view_orders_usecase.dart';
import 'features/login/data/datasources/local_login_user.dart';
import 'features/login/data/reporisatory/account_reporisatory_impl.dart';
import 'features/login/domain/repositories/account_repository.dart';

final sl = GetIt.instance;

void init() {
  //lazy singleton will call the object when needed ONLY, the singleton when the app launched it will
  //the objects
  //new DB
  sl.registerLazySingleton(() => FirebaseDatabseProvider());
  //sl.registerLazySingleton(() => DatabaseProvider());
  //olddb
  sl.registerLazySingleton<LocalDatabaseDataSource>(
      () => DatabaseDataSourceImpl(sl()));

  sl.registerLazySingleton<RemoteLoginDatasource>(
      () => RemoteLoginDatasourceImpl(sl()));

  //Account_Repository
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImlp(sl()));

  //usecases with singelton dessign pattern
  // sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<RemoteLoginUsecase>(() => RemoteLoginUsecase(sl()));
  sl.registerLazySingleton<RemoteLogoutUsecase>(
      () => RemoteLogoutUsecase(sl()));

  //Login bloc cubit
  sl.registerFactory<LoginCubit>(() => LoginCubit());

//-----------------------------------------------------------------------------------------
// Register feature (injection).
//-----------------------------------------------------------------------------------------

  //datasource Register for db
  // sl.registerLazySingleton<RegisterDatasource>(
  //     () => RegisterDatasourceImpl(sl<DatabaseProvider>()));
  sl.registerLazySingleton<RemoteRegisterDatasource>(
      () => RemoteRegisterDatasourceImlp(sl()));

  //Register_Repository
  sl.registerLazySingleton<RegisterAccountRepository>(
      () => RegisterReporisatoryImpl(sl<RemoteRegisterDatasource>()));

  //Registerusecase
  // sl.registerLazySingleton<RegisterUsecase>(
  //     () => RegisterUsecase(sl<RegisterAccountRepository>()));
  sl.registerLazySingleton<RemoteRegisterUsecase>(
      () => RemoteRegisterUsecase(sl<RegisterAccountRepository>()));

  sl.registerLazySingleton<GetUserInfoUsecase>(
      () => GetUserInfoUsecase(sl<RegisterAccountRepository>()));

  //register bloc cubit
  // sl.registerLazySingleton(() => RegisterCubit());

  sl.registerFactory<RegisterCubit>(() => RegisterCubit());

  //-----------------------------------------------------------------------------------------
  // Ticket feature (injection).
  //-----------------------------------------------------------------------------------------

  //datasource event for db
  // sl.registerLazySingleton(() => EventDatasourceImpl(sl()));
  sl.registerLazySingleton<TicketDatasourceInterface>(
      () => RemoteTicketDatasource());

  //Event_Repository
  // sl.registerLazySingleton<EventRepsitory>(() => EventReporisatoryImpl(sl()));
  sl.registerLazySingleton<TicketReporisatory>(
      () => TicketReporisatoryImlp(sl<TicketDatasourceInterface>()));

  // Local Event_Usecases
  // sl.registerLazySingleton(() => GetAllEventsUsecase(sl()));
  // sl.registerLazySingleton(() => GetAllCommentsUsecase(sl()));
  // sl.registerLazySingleton(() => CommentOnEventUsecase(sl()));
  // sl.registerLazySingleton(() => AddEventUsecase(sl()));
  // sl.registerLazySingleton(() => UpdateEventUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteEventUsecase(sl()));

  //Remote_Ticket_Usecases
  sl.registerLazySingleton<AddTicketUsecase>(
      () => AddTicketUsecase(sl<TicketReporisatory>()));
  sl.registerLazySingleton<UpdateTicketUsecase>(
      () => UpdateTicketUsecase(sl<TicketReporisatory>()));
  sl.registerLazySingleton<DeleteTicketUsecase>(
      () => DeleteTicketUsecase(sl<TicketReporisatory>()));
  sl.registerLazySingleton<GetAllTicketUsecase>(
      () => GetAllTicketUsecase(sl<TicketReporisatory>()));
  sl.registerLazySingleton<UploadMessageUsecase>(
      () => UploadMessageUsecase(sl<TicketReporisatory>()));
  sl.registerLazySingleton<GetMessagesUsecase>(
      () => GetMessagesUsecase(sl<TicketReporisatory>()));

  //Event bloc cubit
  // sl.registerLazySingleton(() => EventCubit());
  sl.registerFactory(() => TicketCubit());
  sl.registerFactory(() => ChatCubit());

//-----------------------------------------------------------------------------------------
// Restauratn feature (injection).
//-----------------------------------------------------------------------------------------

//Datasource Restaurant
  sl.registerLazySingleton<RestaurantDatasourceInterface>(
      () => RestaurantDatasourceImpl());

//Repotisatory Restaurant
  sl.registerLazySingleton<RestaurantReporisatory>(
      () => RestaurantReporisatoryImpl(sl()));

  //Restaurant usecase
  sl.registerLazySingleton<AddRestaurantUsecase>(
      () => AddRestaurantUsecase(sl<RestaurantReporisatory>()));

  sl.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(sl<RestaurantReporisatory>()));

  sl.registerLazySingleton<GetUploadedImageUsecase>(
      () => GetUploadedImageUsecase(sl<RestaurantReporisatory>()));

  sl.registerLazySingleton<AddMenuItemsUsecase>(
      () => AddMenuItemsUsecase(sl<RestaurantReporisatory>()));

  sl.registerLazySingleton<GetAllRestaurantUsecase>(
      () => GetAllRestaurantUsecase(sl<RestaurantReporisatory>()));

  sl.registerLazySingleton<GetAllMenuUsecase>(
      () => GetAllMenuUsecase(sl<RestaurantReporisatory>()));

  sl.registerFactory(() => RestaurantCubit());
  sl.registerFactory(() => MenuCubit());

//-----------------------------------------------------------------------------------------
// Cart feature (injection).
//-----------------------------------------------------------------------------------------

//Datasource Cart
  sl.registerLazySingleton<CartDatasourceInterface>(() => CartDatasourceImpl());

//Repotisatory Cart
  sl.registerLazySingleton<CartReporisatoryInterface>(
      () => CartReporisatoryImpl(sl()));

  //Cart usecase
  sl.registerLazySingleton<AddProductToCartUsecase>(
      () => AddProductToCartUsecase(sl<CartReporisatoryInterface>()));

  sl.registerLazySingleton<GetAllCartItemsUsecase>(
      () => GetAllCartItemsUsecase(sl<CartReporisatoryInterface>()));

  sl.registerLazySingleton<ViewOrderUsecase>(
      () => ViewOrderUsecase(sl<CartReporisatoryInterface>()));

  sl.registerLazySingleton<ClearCartItemsUsecase>(
      () => ClearCartItemsUsecase(sl<CartReporisatoryInterface>()));

//AddCartData
  //Cart Cubit
  sl.registerFactory(() => CartCubit());
}
