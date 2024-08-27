import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/common/constant/constant.dart';
import 'package:freezed_example/core/error/exception.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:freezed_example/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:freezed_example/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final InternetConnectionChecker connectionChecker;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, UserCredential?>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return getUser(() async => await authRemoteDataSource
        .signUpWithEmailPassword(name: name, email: email, password: password));
  }

  Future<Either<Failure, UserCredential?>> getUser(
      Future<UserCredential?> Function() fn) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }

      final user = await fn();
      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    return getUser(() async => await authRemoteDataSource
        .logInWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }

      await authRemoteDataSource.logOut();
      return right("Logout Success");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
