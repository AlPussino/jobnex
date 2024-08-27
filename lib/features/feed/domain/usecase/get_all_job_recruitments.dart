import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/feed/domain/repository/feed_repository.dart';

class GetAllJobRecruitments
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final FeedRepository feedRepository;
  const GetAllJobRecruitments(this.feedRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      NoParams params) async {
    return await feedRepository.getAllJobRecruitments();
  }
}
