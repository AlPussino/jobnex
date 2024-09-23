import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/profile/domain/repository/user_repository.dart';

class ChangeCompanyName
    implements FutureUseCase<Null, ChangeCompanyNameParams> {
  final UserRepository userRepository;
  const ChangeCompanyName(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeCompanyNameParams params) async {
    return await userRepository.changeCompanyName(
      workExperience_id: params.workExperience_id,
      company_name: params.company_name,
    );
  }
}

class ChangeCompanyNameParams {
  final String workExperience_id;
  final String company_name;
  const ChangeCompanyNameParams({
    required this.workExperience_id,
    required this.company_name,
  });
}
