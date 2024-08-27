import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class ChangeCoverImage implements FutureUseCase<Null, ChangeCoverImageParams> {
  final UserRepository userRepository;
  const ChangeCoverImage(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeCoverImageParams params) async {
    return await userRepository.changeCoverImage(image_file: params.image_file);
  }
}

class ChangeCoverImageParams {
  final File image_file;
  const ChangeCoverImageParams({
    required this.image_file,
  });
}
