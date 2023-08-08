import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/pages/widgets/tickets_list_title_widget.dart';

class TicketWidget extends StatefulWidget {
  final List<EventEntity> eventEntity;
  const TicketWidget({
    Key? key,
    required this.eventEntity,
  }) : super(key: key);

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  Future<void> _refresh() async {
    setState(() {
      context.read<TicketCubit>().getAllTickets();
    });
    return await Future.delayed(
      const Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      thickness: 1,
      height: 3,
    );
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          divider,
          Expanded(
            child: ListView.separated(
                itemCount: widget.eventEntity.length,
                itemBuilder: (context, index) {
                  return TicketsListTitleWidget(
                    title: widget.eventEntity[index].title ?? '',
                    subTitle: widget.eventEntity[index].description ?? '',
                    eventEntity: widget.eventEntity[index],
                  );
                },
                separatorBuilder: (context, index) => divider),
          ),
        ],
      ),
    );
  }
}
