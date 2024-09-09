abstract class PostOwnerEvent {}

class FetchPostOwner extends PostOwnerEvent {
  final String post_owner_id;
  FetchPostOwner(this.post_owner_id);
}
