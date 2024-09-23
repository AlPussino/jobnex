import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/auth/domain/repository/auth_repository.dart';

class SignUpWithEmailAndPassword
    implements
        FutureUseCase<UserCredential?, SignUpWithEmailAndPasswordParams> {
  final AuthRepository authRepository;
  const SignUpWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, UserCredential?>> call(
      SignUpWithEmailAndPasswordParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpWithEmailAndPasswordParams {
  final String email;
  final String password;
  final String name;
  const SignUpWithEmailAndPasswordParams(
      {required this.email, required this.password, required this.name});
}
