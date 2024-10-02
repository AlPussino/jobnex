import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_reply.freezed.dart';
part 'chat_reply.g.dart';

@unfreezed
class ChatReply with _$ChatReply {
  const ChatReply._();

  factory ChatReply({
    required String message,
    required String message_type,
    required String message_owner_id,
  }) = _ChatReply;

  factory ChatReply.fromJson(Map<String, dynamic> json) =>
      _$ChatReplyFromJson(json);
}
