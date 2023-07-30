import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/pages/widgets/event_details_page/event_detail_page.dart';

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
    return Future.delayed(
      const Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        itemCount: widget.eventEntity.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: const Icon(Icons.arrow_circle_right),
            title: Text(
              widget.eventEntity[index].title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.eventEntity[index].description!,
              style: const TextStyle(fontSize: 16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsPage(
                    eventEntity: widget.eventEntity[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1),
      ),
    );
  }
}
