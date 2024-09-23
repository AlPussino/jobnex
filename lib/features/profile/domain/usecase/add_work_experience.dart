import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/profile/data/model/work_experience.dart';
import 'package:JobNex/features/profile/domain/repository/user_repository.dart';

class AddWorkExperience
    implements FutureUseCase<void, AddWorkExperienceParams> {
  final UserRepository userRepository;
  const AddWorkExperience(this.userRepository);

  @override
  Future<Either<Failure, void>> call(AddWorkExperienceParams params) async {
    return await userRepository.addWorkExperience(
        workExperience: params.workExperience);
  }
}

class AddWorkExperienceParams {
  final WorkExperience workExperience;
  const AddWorkExperienceParams({
    required this.workExperience,
  });
}
