import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/event_entities.dart';
import 'event_details_page/event_detail_page.dart';

class TicketsListTitleWidget extends StatelessWidget {
  const TicketsListTitleWidget({
    Key? key,
    required this.eventEntity,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final EventEntity eventEntity;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.arrow_circle_right),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(fontSize: 16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      onTap: () {
        Get.to(() => EventDetailsPage(eventEntity: eventEntity));
      },
    );
  }
}
