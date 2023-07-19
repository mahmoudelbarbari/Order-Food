import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:order/core/bloc_observer/bloc_observer.dart';
import 'package:order/core/theme_app.dart';
import 'package:order/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:order/features/cart/presentation/pages/cart_page.dart';
import 'package:order/features/event/presentation/cubit/cubit_message/chat_cubit.dart';
import 'package:order/features/event/presentation/pages/ticket_page.dart';
import 'package:order/features/login/presentation/cubit/login_cubit.dart';
import 'package:order/features/register/presentation/cubit/register_cubit.dart';
import 'package:order/features/register/presentation/pages/register_page.dart';
import 'package:order/features/restaurant/presentation/cubit/menu_cubit.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/pages/get_all_restaurants_page/all_restaurants_page.dart';
import 'package:order/features/restaurant/presentation/pages/menu_page/menu_page.dart';
import 'package:order/features/restaurant/presentation/pages/add_restaurant_page.dart';
import 'core/services/push_notification_service.dart';
import 'features/event/presentation/cubit/ticket_cubit.dart';
import 'firebase_options.dart';
import 'injection_container.dart'
    as di; // di shortcut for Dependency injection.
import 'features/login/presentation/pages/login_page.dart';

void main() async {
  di.init();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // await di.sl<DatabaseProvider>().initDB(); sqlite DB

    Bloc.observer = MyGlobalObserver();

    runApp(const MyApp());
  }, (e, s) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<LoginCubit>()),
          BlocProvider(create: (_) => di.sl<RegisterCubit>()),
          BlocProvider(create: (_) => di.sl<TicketCubit>()..getAllTickets()),
          BlocProvider(
              create: (_) => di.sl<RestaurantCubit>()..getAllRestaurants()),
          BlocProvider(create: (_) => di.sl<MenuCubit>()..getAllMenu()),
          BlocProvider(create: (_) => di.sl<CartCubit>()..getAllCartItems()),
          BlocProvider(create: (_) => di.sl<ChatCubit>()..getChatData()),
        ],
        child: MaterialApp(
          title: 'Food App',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          routes: {
            'login': (context) => const LoginPage(),
            'register': (context) => const RegisterPage(),
            'home': (context) => const TicketPage(),
            'restaurant': (context) => const RestaurantPage(),
            'menu': (context) => const MenuPage(),
            'allrestaurant': (context) => const AllRestaurantPage(),
            'cart': (context) => const CartPage(),
          },
          home: const LoginPage(),
        ));
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
