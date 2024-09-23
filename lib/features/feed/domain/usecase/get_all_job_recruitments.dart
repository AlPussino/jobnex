import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/feed/domain/repository/feed_repository.dart';

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
