import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class GetUserJobRecruitments
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetUserJobRecruitmentsParams> {
  final UserRepository userRepository;
  const GetUserJobRecruitments(this.userRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetUserJobRecruitmentsParams params) async {
    return await userRepository.getUserJobRecruitments(user_id: params.user_id);
  }
}

class GetUserJobRecruitmentsParams {
  final String user_id;
  const GetUserJobRecruitmentsParams({
    required this.user_id,
  });
}
