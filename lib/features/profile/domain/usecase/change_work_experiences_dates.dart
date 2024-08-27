import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class ChangeWorkExperiencesDates
    implements FutureUseCase<Null, ChangeWorkExperiencesDatesParams> {
  final UserRepository userRepository;
  const ChangeWorkExperiencesDates(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(
      ChangeWorkExperiencesDatesParams params) async {
    return await userRepository.changeWorkExperiencesDates(
      workExperience_id: params.workExperience_id,
      start_date: params.start_date,
      stop_date: params.stop_date,
      still_working: params.still_working,
    );
  }
}

class ChangeWorkExperiencesDatesParams {
  final String workExperience_id;
  final String start_date;
  final String stop_date;
  final bool still_working;
  const ChangeWorkExperiencesDatesParams({
    required this.workExperience_id,
    required this.start_date,
    required this.stop_date,
    required this.still_working,
  });
}
