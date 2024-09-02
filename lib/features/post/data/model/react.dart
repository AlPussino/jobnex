import 'package:freezed_annotation/freezed_annotation.dart';
part 'react.freezed.dart';
part 'react.g.dart';

@unfreezed
class React with _$React {
  const React._();

  factory React({
    required String react_owner_id,
    required String react,
  }) = _React;

  factory React.fromJson(Map<String, dynamic> json) => _$ReactFromJson(json);
}
