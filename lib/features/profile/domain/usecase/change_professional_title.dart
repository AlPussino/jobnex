import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/profile/domain/repository/user_repository.dart';

class ChangeProfessionalTitle
    implements FutureUseCase<Null, ChangeProfessionalTitleParams> {
  final UserRepository userRepository;
  const ChangeProfessionalTitle(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(
      ChangeProfessionalTitleParams params) async {
    return await userRepository.changeProfessionalTitle(
        professional_titlte: params.professional_title);
  }
}

class ChangeProfessionalTitleParams {
  final String professional_title;
  const ChangeProfessionalTitleParams({
    required this.professional_title,
  });
}
