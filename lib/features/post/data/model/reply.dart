import 'package:freezed_annotation/freezed_annotation.dart';
part 'reply.freezed.dart';
part 'reply.g.dart';

@unfreezed
class Reply with _$Reply {
  const Reply._();

  factory Reply({
    required String reply_id,
    required String reply_owner_id,
    required String reply,
    required DateTime created_at,
  }) = _Reply;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}
