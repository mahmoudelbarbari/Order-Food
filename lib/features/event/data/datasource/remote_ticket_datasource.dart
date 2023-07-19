import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order/features/event/data/models/event_model.dart';
import 'package:order/features/event/data/models/titcket_model.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/login/domain/entities/account_entites.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseDatasourceProvider._internal();
}

abstract class TicketDatasourceInterface extends FirebaseDatasourceProvider {
  TicketDatasourceInterface() : super._internal();

  Future<List<EventEntity>> remoteGetAllTickets();
  Future<BaseResponse> remoteAddTicket(EventModel eventModel);
  Future<BaseResponse> remoteUpdateTicket(EventModel eventModel);
  Future<BaseResponse> remoteDeleteTicket();
  Future<BaseResponse> uploadMessage(
      String idUser, String message, Account account);
  Future<List<ChattModel>> getAllMessages();
}

class RemoteTicketDatasource extends TicketDatasourceInterface {
  RemoteTicketDatasource() : super();

  @override
  Future<BaseResponse> remoteAddTicket(EventModel eventModel) async {
    try {
      await firebaseFirestore.collection("Ticket").doc().set({
        "title": eventModel.title,
        "description": eventModel.description,
      });
      return BaseResponse(status: true, message: "Ticket Added Successfully");
    } catch (e) {
      return BaseResponse(status: false, message: "Something went wrong");
    }
  }

  @override
  Future<BaseResponse> remoteDeleteTicket() async {
    try {
      await firebaseFirestore.doc("Ticket").delete();
      return BaseResponse(status: true, message: "Ticket Added Successfully");
    } catch (e) {
      return BaseResponse(status: false, message: "Something went wrong");
    }
  }

  @override
  Future<List<EventEntity>> remoteGetAllTickets() async {
    final retrive = firebaseFirestore.collection("Ticket");
    final querySnapshot = await retrive.get();
    querySnapshot.docs.map((doc) => doc.data()).toList();
    List<EventModel> events = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      events.add(EventModel.fromSnapShot(doc));
    }
    return events;
  }

  @override
  Future<BaseResponse> remoteUpdateTicket(EventModel eventModel) async {
    try {
      await firebaseFirestore.doc("Ticket").update({
        "title": eventModel.title,
        "description": eventModel.description,
      });
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
    return BaseResponse(status: false, message: "Something went wrong!");
  }

  @override
  Future<BaseResponse> uploadMessage(
      String idUser, String message, Account account) async {
    try {
      var uID = firebaseAuth.currentUser!.uid;
      final currentUser = firebaseAuth.currentUser!.email;
      await firebaseFirestore.collection("Messages").add({
        'idUser': uID,
        'message': message,
        'timestamp': DateTime.now(),
        'senderEmail': currentUser,
      });
      return BaseResponse(status: true, message: "Message send Succeflluy");
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<List<ChattModel>> getAllMessages() async {
    final retrive = firebaseFirestore.collection("Messages");
    final querySnapshot = await retrive.get();
    querySnapshot.docs.map((doc) => doc.data()).toSet();
    List<ChattModel> chatModel = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      chatModel.add(ChattModel.fromSnapshot(doc));
    }
    return chatModel;
  }
}
