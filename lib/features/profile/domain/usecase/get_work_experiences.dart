import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class GetWorkExperiences
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetWorkExperiencesParams> {
  final UserRepository userRepository;
  const GetWorkExperiences(this.userRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetWorkExperiencesParams params) async {
    return await userRepository.getWorkExperiences(user_id: params.user_id);
  }
}

class GetWorkExperiencesParams {
  final String user_id;
  const GetWorkExperiencesParams({
    required this.user_id,
  });
}
