import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/features/auth/domain/usecase/log_in_with_email_and_password.dart';
import 'package:JobNex/features/auth/domain/usecase/sign_up_with_email_and_password.dart';
import '../../domain/usecase/log_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmailAndPassword _signUpWithEmailAndPassword;
  final LogInWithEmailAndPassword _logInWithEmailAndPassword;
  final LogOut _logOut;

  AuthBloc({
    required SignUpWithEmailAndPassword signUpWithEmailAndPassword,
    required LogInWithEmailAndPassword logInWithEmailAndPassword,
    required LogOut logOut,
  })  : _signUpWithEmailAndPassword = signUpWithEmailAndPassword,
        _logInWithEmailAndPassword = logInWithEmailAndPassword,
        _logOut = logOut,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(onAuthSignUp);
    on<AuthLogIn>(onAuthLogIn);
    on<AuthLogOut>(onAuthLogOut);
  }

//
  void onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _signUpWithEmailAndPassword(
        SignUpWithEmailAndPasswordParams(
            name: event.name, email: event.email, password: event.password));
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    final response = await _logInWithEmailAndPassword(
        LogInWithEmailAndPasswordParams(
            email: event.email, password: event.password));
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void onAuthLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    final response = await _logOut.call(const LogOutParams());
    response.fold((failure) => emit(AuthFailure(failure.message)),
        (message) => emit(AuthLogOutSuccess(message)));
  }
}
