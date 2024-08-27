import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class ChangeName implements FutureUseCase<Null, ChangeNameParams> {
  final UserRepository userRepository;
  const ChangeName(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeNameParams params) async {
    return await userRepository.changeName(
      name: params.name,
    );
  }
}

class ChangeNameParams {
  final String name;
  const ChangeNameParams({
    required this.name,
  });
}
