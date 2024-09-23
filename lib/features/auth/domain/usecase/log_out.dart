import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/auth/domain/repository/auth_repository.dart';

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
