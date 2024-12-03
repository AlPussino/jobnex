import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_call.freezed.dart';
part 'video_call.g.dart';

@unfreezed
class VideoCall with _$VideoCall {
  const VideoCall._();

  factory VideoCall({
    required String caller_id,
    required String receiver_id,
    required bool is_accepted,
  }) = _VideoCall;

  factory VideoCall.fromJson(Map<String, dynamic> json) =>
      _$VideoCallFromJson(json);
}
