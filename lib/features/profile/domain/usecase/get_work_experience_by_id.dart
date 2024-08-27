import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class GetWorkExperienceById
    implements
        FutureUseCase<Stream<DocumentSnapshot<Map<String, dynamic>>>,
            GetWorkExperienceByIdParams> {
  final UserRepository userRepository;
  const GetWorkExperienceById(this.userRepository);

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> call(
      GetWorkExperienceByIdParams params) async {
    return await userRepository.getWorkExperienceById(
        user_id: params.user_id, workexperience_id: params.workexperience_id);
  }
}

class GetWorkExperienceByIdParams {
  final String user_id;
  final String workexperience_id;
  const GetWorkExperienceByIdParams({
    required this.user_id,
    required this.workexperience_id,
  });
}
