import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';

class GetUserInfo
    implements
        FutureUseCase<Stream<DocumentSnapshot<Map<String, dynamic>>>,
            GetUserInfoParams> {
  final UserRepository userRepository;
  const GetUserInfo(this.userRepository);

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> call(
      GetUserInfoParams params) async {
    return await userRepository.getUserInfo(user_id: params.user_id);
  }
}

class GetUserInfoParams {
  final String user_id;
  const GetUserInfoParams({
    required this.user_id,
  });
}
