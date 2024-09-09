import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostOwnerState {}

class PostOwnerInitial extends PostOwnerState {}

class PostOwnerLoading extends PostOwnerState {}

class PostOwnerLoaded extends PostOwnerState {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> postOwnerData;
  PostOwnerLoaded(this.postOwnerData);
}

class PostOwnerError extends PostOwnerState {
  final String message;
  PostOwnerError(this.message);
}
