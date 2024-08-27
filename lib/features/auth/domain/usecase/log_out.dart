import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/auth/domain/repository/auth_repository.dart';

class LogOut implements FutureUseCase<String, LogOutParams> {
  final AuthRepository authRepository;
  const LogOut(this.authRepository);

  @override
  Future<Either<Failure, String>> call(LogOutParams params) async {
    return await authRepository.logOut();
  }
}

class LogOutParams {
  const LogOutParams();
}
