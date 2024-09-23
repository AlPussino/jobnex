import 'package:bloc/bloc.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'post_owner_event.dart';
import 'post_owner_state.dart';

class PostOwnerBloc extends Bloc<PostOwnerEvent, PostOwnerState> {
  final GetPostOwnerInfo _postOwnerRepository;

  PostOwnerBloc({
    required GetPostOwnerInfo postOwnerRepository,
  })  : _postOwnerRepository = postOwnerRepository,
        super(PostOwnerInitial()) {
    on<PostOwnerEvent>((_, emit) => emit(PostOwnerLoading()));
    on<FetchPostOwner>(onFetchPostOwner);
  }

  void onFetchPostOwner(FetchPostOwner event, Emitter<PostOwnerState> emit) {
    final postOwner = _postOwnerRepository.getPostOwnerInfo(
        post_owner_id: event.post_owner_id);

    emit(PostOwnerLoaded(postOwner));
  }
}
