import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential?>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserCredential?>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> logOut();
}
