class EventEntity {
  int? id;
  String? title;
  String? description;
  String? comment;

  EventEntity({
    this.id,
    this.title,
    this.description,
    this.comment,
  });
}

class CommentEntity {
  int? id;
  String comment;
  CommentEntity({this.id, required this.comment});
}

class BaseResponse {
  bool status;
  String message;

  BaseResponse({required this.status, required this.message});
}

class MessageEntity {
  final String userId;
  final String message;
  final String senderName;
  final String receiverName;

  MessageEntity(
    this.userId,
    this.message,
    this.senderName,
    this.receiverName,
  );
}
