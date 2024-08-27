part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserGetUserInfo extends UserEvent {
  final String user_id;
  UserGetUserInfo(this.user_id);
}

final class UserChangeName extends UserEvent {
  final String name;
  UserChangeName(this.name);
}

final class UserChangeGender extends UserEvent {
  final String gender;
  UserChangeGender(this.gender);
}

final class UserChangeNationality extends UserEvent {
  final String nationality;
  UserChangeNationality(this.nationality);
}

final class UserChangeMobileNumber extends UserEvent {
  final String mobile_number;
  UserChangeMobileNumber(this.mobile_number);
}

final class UserChangeAddress extends UserEvent {
  final String address;
  UserChangeAddress(this.address);
}

final class UserChangeBirthDate extends UserEvent {
  final String birth_date;
  UserChangeBirthDate(this.birth_date);
}

final class UserChangeProfessionalTitle extends UserEvent {
  final String prefessional_title;
  UserChangeProfessionalTitle(this.prefessional_title);
}

final class UserChangeProfileImage extends UserEvent {
  final File image_file;
  UserChangeProfileImage(this.image_file);
}

final class UserChangeCoverImage extends UserEvent {
  final File image_file;
  UserChangeCoverImage(this.image_file);
}

final class UserGetUserJobRecruitments extends UserEvent {
  final String user_id;
  UserGetUserJobRecruitments(this.user_id);
}
