import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/app_bar_widget.dart';
import 'package:order/core/widgets/loading_widget.dart';
import 'package:order/core/widgets/snackbar_message.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/cubit/ticket_state.dart';
import 'package:order/features/event/presentation/pages/ticket_page.dart';
import 'package:order/features/event/presentation/pages/widgets/event_add_update_pages/form_widget.dart';

class EventAddUpdatePage extends StatelessWidget {
  final EventEntity? eventEntity;
  final bool isUpdateEvent;
  const EventAddUpdatePage(
      {Key? key, this.eventEntity, required this.isUpdateEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          pageName: isUpdateEvent ? "Add Event" : "Edit Event",
          centerTitle: false),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<TicketCubit, TicketState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdateEventState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              context.read<TicketCubit>().getAllTickets();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const TicketPage()),
                  (route) => false);
            } else if (state is TicketErrorState) {
              final snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is TicketLoadingState) {
              return const LoadingWidget();
            }

            return FormWidget(
                isUpdateEvent: isUpdateEvent,
                eventEntity: isUpdateEvent ? eventEntity : null);
          },
        ),
      ),
    );
  }
}
