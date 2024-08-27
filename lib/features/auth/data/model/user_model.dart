import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String user_id,
    required String name,
    required String email,
    required String mobile_number,
    required String gender,
    required DateTime birth_date,
    required String professional_title,
    required String nationality,
    required List<String> skill,
    required String fcm_token,
    required bool is_online,
    required DateTime last_online,
    required bool in_chat,
    required String profile_url,
    required String cover_url,
    required double latitude,
    required double longitude,
    required String address,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object> json) =>
      _$UserModelFromJson(json);
}
