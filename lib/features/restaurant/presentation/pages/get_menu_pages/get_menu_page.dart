import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/drawer_menu.dart';
import 'package:order/core/widgets/loading_widget.dart';
import 'package:order/features/restaurant/presentation/cubit/menu_cubit.dart';
import 'package:order/features/restaurant/presentation/cubit/menu_state.dart';
import 'package:order/features/restaurant/presentation/pages/get_menu_pages/get_menu_widget.dart';

class AllMenuPage extends StatefulWidget {
  const AllMenuPage({
    super.key,
  });

  @override
  State<AllMenuPage> createState() => _AllMenuPageState();
}

class _AllMenuPageState extends State<AllMenuPage> {
  _AllMenuPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Restaurant'),
      ),
      drawer: const NavigationDrawerr(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<MenuCubit, MenuState>(
          listener: (context, state) {
            if (state is MenuError) {
              if (kDebugMode) {
                print(state.errorMessage);
              }
            }
          },
          builder: (context, state) {
            if (state is MenuLoaded) {
              return AllMenuWidget(
                menuModel: state.menuModel,
              );
            } else if (state is MenuError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errorMessage)));
              if (kDebugMode) {
                print(state.errorMessage);
              }
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
