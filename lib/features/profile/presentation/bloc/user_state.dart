part of 'user_bloc.dart';

@immutable
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFailure extends UserState {
  final String message;
  const UserFailure(this.message);
}

final class UserSuccess extends UserState {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> userInfo;
  const UserSuccess(this.userInfo);
}

final class UserChangeNameSuccess extends UserState {}

final class UserChangeGenderSuccess extends UserState {}

final class UserChangeNationalitySuccess extends UserState {}

final class UserChangeMobileNumberSuccess extends UserState {}

final class UserChangeAddressSuccess extends UserState {}

final class UserChangeBirthDateSuccess extends UserState {}

final class UserChangeProfessionalTitleSuccess extends UserState {}

final class UserChangeProfileImageSuccess extends UserState {}

final class UserChangeCoverImageSuccess extends UserState {}

final class UserGetUserJobRecruitmentsSuccess extends UserState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> jobRecruitments;
  const UserGetUserJobRecruitmentsSuccess(this.jobRecruitments);
}
