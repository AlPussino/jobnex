import 'package:freezed_annotation/freezed_annotation.dart';
part 'job_applier.freezed.dart';
part 'job_applier.g.dart';

@freezed
class JobApplier with _$JobApplier {
  const JobApplier._();

  const factory JobApplier({
    required String applier_id,
    required String applier_name,
    required String applier_profile,
  }) = _JobApplier;

  factory JobApplier.fromJson(Map<String, Object> json) =>
      _$JobApplierFromJson(json);
}
