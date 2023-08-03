import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/loading_widget.dart';
import 'package:order/features/event/data/models/titcket_model.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/presentation/cubit/cubit_message/chat_cubit.dart';
import 'package:order/features/event/presentation/cubit/cubit_message/chat_state.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/login/domain/entities/account_entites.dart';

class EventDetailWidget extends StatefulWidget {
  final EventEntity eventEntity;
  final List<ChattModel> chatModel;
  const EventDetailWidget({
    Key? key,
    required this.chatModel,
    required this.eventEntity,
  }) : super(key: key);

  @override
  State<EventDetailWidget> createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {
  TextEditingController addCommentcontroller = TextEditingController();
  Account account = Account();

  Future<void> refresh() async {
    setState(() {
      context.read<ChatCubit>().getChatData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: ((context, state) {
      if (state is ChatLoadedState) {
        return _bodyWidget(state);
      } else if (state is ChatErrorState) {
        if (kDebugMode) {
          print(state.errorMessage);
        }
      }
      return const LoadingWidget();
    }));
  }

  Widget _bodyWidget(ChatLoadedState messages) {
    return Column(
      children: [
        _listEventWidget(),
        _listMessagesWidget(messages),
        _sendTextMessageWidget(),
      ],
    );
  }

  Widget _listMessagesWidget(ChatLoadedState messages) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.chatModel.length,
          itemBuilder: (_, index) {
            return Container(
              height: 100,
              width: 45,
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 7,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.person,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.chatModel[index].senderEmail),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.chatModel[index].message),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _listEventWidget() {
    return BlocProvider(
        create: (_) => TicketCubit(),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                widget.eventEntity.title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.eventEntity.description!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              color: Colors.orange,
              thickness: 2.4,
            ),
          ],
        ));
  }

  Widget _sendTextMessageWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: addCommentcontroller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.message),
          border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0),
              gapPadding: 10,
              borderRadius: BorderRadius.circular(25)),
          labelText: "Write a comment... ",
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            splashColor: Colors.black,
            tooltip: "Post comment ",
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              var uID = auth.currentUser!.uid;
              auth.currentUser!.email;
              BlocProvider.of<TicketCubit>(context)
                  .remoteAddMessage(uID, addCommentcontroller.text, account);
            },
          ),
        ),
      ),
    );
  }
}
