import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/domain/remote_usecases/add_ticket.dart';
import 'package:order/features/event/domain/remote_usecases/delete_ticket.dart';
import 'package:order/features/event/domain/remote_usecases/message_usecase.dart';
import 'package:order/features/event/domain/remote_usecases/remote_get_all_ticket.dart';
import 'package:order/features/event/domain/remote_usecases/update_ticket.dart';
import 'package:order/features/event/presentation/cubit/ticket_state.dart';
import 'package:order/features/login/domain/entities/account_entites.dart';
import 'package:order/injection_container.dart';

class TicketCubit extends Cubit<TicketState> {
  late AddTicketUsecase addTicketUsecase;
  late DeleteTicketUsecase deleteTicketUsecase;
  late UpdateTicketUsecase updateTicketUsecase;
  late GetAllTicketUsecase getAllTicketUsecase;
  late UploadMessageUsecase uploadMessageUsecase;
  TicketCubit() : super(TicketStateInt());

  Future<void> getAllTickets() async {
    try {
      emit(TicketLoadingState());
      getAllTicketUsecase = sl();
      final allTicket = await getAllTicketUsecase.call();
      emit(TicketLoadedState(eventEntity: allTicket));
    } catch (e) {
      emit(TicketErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addTicket(EventEntity eventEntity) async {
    try {
      emit(TicketLoadingState());
      addTicketUsecase = sl();
      getAllTicketUsecase = sl();
      final allData = await getAllTicketUsecase.call();
      final addedTicket = await addTicketUsecase.call(eventEntity);
      if (addedTicket.status) {
        emit(TicketSuccessState(addedTicket));
        emit(TicketLoadedState(eventEntity: allData));
      } else {
        emit(TicketErrorState(errorMessage: addedTicket.message));
      }
    } catch (e) {
      emit(TicketErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> remoteAddMessage(
      String idUser, String message, Account account) async {
    try {
      emit(TicketLoadingState());
      uploadMessageUsecase = sl();
      final addedMessage =
          await uploadMessageUsecase.call(idUser, message, account);
      emit(MessageSuccessState(addedMessage));
    } catch (e) {
      emit(TicketErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteTicket() async {
    try {
      emit(TicketLoadingState());
      deleteTicketUsecase = sl();
      final deletedTicket = await deleteTicketUsecase.call();
      if (deletedTicket.status) {
        emit(TicketDeletedSuccessState(deletedTicket));
      } else {
        emit(TicketErrorState(errorMessage: deletedTicket.message));
      }
    } catch (e) {
      emit(TicketErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> updateTicket(EventEntity eventEntity) async {
    try {
      emit(TicketLoadingState());
      updateTicketUsecase = sl();
      final updatedTicket = await updateTicketUsecase.call(eventEntity);
      if (updatedTicket.status) {
        emit(TicketSuccessState(updatedTicket));
      } else {
        emit(TicketErrorState(errorMessage: updatedTicket.message));
      }
    } catch (e) {
      emit(TicketErrorState(errorMessage: e.toString()));
    }
  }
}
