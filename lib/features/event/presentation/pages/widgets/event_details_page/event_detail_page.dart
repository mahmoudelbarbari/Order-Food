import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/drawer_menu.dart';
import 'package:order/core/error/widgets/loading_widget.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/presentation/cubit/cubit_message/chat_cubit.dart';
import 'package:order/features/event/presentation/cubit/cubit_message/chat_state.dart';
import 'package:order/features/event/presentation/pages/widgets/event_details_page/event_detail_widget.dart';

class EventDetailsPage extends StatefulWidget {
  final EventEntity eventEntity;
  const EventDetailsPage({
    Key? key,
    required this.eventEntity,
  }) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    return Scaffold(
        drawer: const NavigationDrawerr(),
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatErrorState) {
              if (kDebugMode) {
                print(state.errorMessage);
              }
            } else if (state is ChatLoadedState) {
              return EventDetailWidget(
                eventEntity: widget.eventEntity,
                chatModel: state.messages,
              );
            }
            return const LoadingWidget();
          },
        ));
  }
}
