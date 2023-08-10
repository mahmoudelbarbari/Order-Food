import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/pages/ticket_page.dart';
import 'package:order/features/event/presentation/pages/widgets/event_add_update_pages/form_submit_btn.dart';
import 'package:order/features/event/presentation/pages/widgets/event_add_update_pages/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final EventEntity? eventEntity;
  final bool isUpdateEvent;
  const FormWidget(
      {Key? key, required this.eventEntity, required this.isUpdateEvent})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateEvent) {
      titleController.text = widget.eventEntity!.title!;
      descriptionController.text = widget.eventEntity!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormFieldWidget(
                  name: "Title",
                  multiLines: false,
                  controller: titleController),
              TextFormFieldWidget(
                  name: "Body",
                  multiLines: true,
                  controller: descriptionController),
              FormSubmitBtn(
                  isUpdateEvent: widget.isUpdateEvent,
                  onPressed: () {
                    validateFormThenUpdateOrAddPost();
                  }),
            ]),
      ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("You created an ticket successfully")));
      final eventEntity = EventEntity(
        id: widget.isUpdateEvent ? widget.eventEntity!.id : null,
        title: titleController.text,
        description: descriptionController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TicketPage()),
      );
      if (widget.isUpdateEvent) {
        BlocProvider.of<TicketCubit>(context).updateTicket(eventEntity);
      } else {
        BlocProvider.of<TicketCubit>(context).addTicket(eventEntity);
      }
    }
  }
}
