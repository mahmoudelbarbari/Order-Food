import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/event/domain/entities/remote_chat_entities.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    int? id,
    required String comment,
  }) : super(
          id: id,
          comment: comment,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comment': comment,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      comment: map['comment'],
    );
  }

  factory CommentModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return CommentModel(
      id: documentSnapshot.data()!['id'],
      comment: documentSnapshot.data()!['comment'],
    );
  }

  factory CommentModel.fromEntity(CommentEntity commentEntity) => CommentModel(
        id: commentEntity.id,
        comment: commentEntity.comment,
      );
}

class EventModel extends EventEntity {
  EventModel({
    int? id,
    String? title,
    String? description,
    String? comment,
  }) : super(
          id: id,
          title: title,
          description: description,
          comment: comment,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  factory EventModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return EventModel(
      id: documentSnapshot.data()!['id'],
      title: documentSnapshot.data()!['title'],
      description: documentSnapshot.data()!['description'],
      comment: documentSnapshot.data()!['comment'],
    );
  }

  // factory EventModel.fromSnapShot2(
  //     DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //   return EventModel(
  //     comment: documentSnapshot.data()!['comment'],
  //   );
  // }

  factory EventModel.fromEntity(EventEntity eventEntity) => EventModel(
        id: eventEntity.id,
        title: eventEntity.title,
        description: eventEntity.description,
        comment: eventEntity.comment,
      );
}

class ChateMessageModel extends ChatMessages {
  ChateMessageModel({
    String? idFrom,
    required String content,
  }) : super(
          idFrom: idFrom,
          content: content,
        );

  Map<String, dynamic> toJson() {
    return {
      idFrom!: idFrom,
      content: content,
    };
  }
}
