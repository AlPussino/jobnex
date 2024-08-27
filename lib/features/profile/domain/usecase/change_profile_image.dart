import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class ChangeProfileImage
    implements FutureUseCase<Null, ChangeProfileImageParams> {
  final UserRepository userRepository;
  const ChangeProfileImage(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeProfileImageParams params) async {
    return await userRepository.changeProfileImage(
        image_file: params.image_file);
  }
}

class ChangeProfileImageParams {
  final File image_file;
  const ChangeProfileImageParams({
    required this.image_file,
  });
}
