import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class ChangeJobType implements FutureUseCase<Null, ChangeJobTypeParams> {
  final UserRepository userRepository;
  const ChangeJobType(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeJobTypeParams params) async {
    return await userRepository.changeJobType(
        workExperience_id: params.workExperience_id, job_type: params.job_type);
  }
}

class ChangeJobTypeParams {
  final String workExperience_id;
  final String job_type;
  const ChangeJobTypeParams({
    required this.workExperience_id,
    required this.job_type,
  });
}
