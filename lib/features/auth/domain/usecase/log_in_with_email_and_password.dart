import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/auth/domain/repository/auth_repository.dart';

class LogInWithEmailAndPassword
    implements FutureUseCase<UserCredential?, LogInWithEmailAndPasswordParams> {
  final AuthRepository authRepository;
  const LogInWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, UserCredential?>> call(
      LogInWithEmailAndPasswordParams params) async {
    return await authRepository.logInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LogInWithEmailAndPasswordParams {
  final String email;
  final String password;
  const LogInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
