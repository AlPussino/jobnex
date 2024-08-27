import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class ChangeNationality
    implements FutureUseCase<Null, ChangeNationalityParams> {
  final UserRepository userRepository;
  const ChangeNationality(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeNationalityParams params) async {
    return await userRepository.changeNationality(
      nationality: params.nationality,
    );
  }
}

class ChangeNationalityParams {
  final String nationality;
  const ChangeNationalityParams({
    required this.nationality,
  });
}
