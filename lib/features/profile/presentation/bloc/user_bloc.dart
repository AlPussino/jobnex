import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/features/profile/domain/usecase/change_address.dart';
import 'package:JobNex/features/profile/domain/usecase/change_birth_date.dart';
import 'package:JobNex/features/profile/domain/usecase/change_cover_image.dart';
import 'package:JobNex/features/profile/domain/usecase/change_gender.dart';
import 'package:JobNex/features/profile/domain/usecase/change_mobile_number.dart';
import 'package:JobNex/features/profile/domain/usecase/change_name.dart';
import 'package:JobNex/features/profile/domain/usecase/change_nationality.dart';
import 'package:JobNex/features/profile/domain/usecase/change_professional_title.dart';
import 'package:JobNex/features/profile/domain/usecase/change_profile_image.dart';
import 'package:JobNex/features/profile/domain/usecase/get_user_info.dart';
import 'package:JobNex/features/profile/domain/usecase/get_user_job_recruitments.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserInfo _getUserInfo;
  final ChangeName _changeName;
  final ChangeGender _changeGender;
  final ChangeNationality _changeNationality;
  final ChangeMobileNumber _changeMobileNumber;
  final ChangeAddress _changeAddress;
  final ChangeBirthDate _changeBirthDate;
  final ChangeProfessionalTitle _changeProfessionalTitle;
  final ChangeProfileImage _changeProfileImage;
  final ChangeCoverImage _changeCoverImage;
  final GetUserJobRecruitments _getUserJobRecruitments;

  UserBloc({
    required GetUserInfo getUserInfo,
    required ChangeName changeName,
    required ChangeGender changeGender,
    required ChangeNationality changeNationality,
    required ChangeMobileNumber changeMobileNumber,
    required ChangeAddress changeAddress,
    required ChangeBirthDate changeBirthDate,
    required ChangeProfessionalTitle changeProfessionalTitle,
    required ChangeProfileImage changeProfileImage,
    required ChangeCoverImage changeCoverImage,
    required GetUserJobRecruitments getUserJobRecruitments,
  })  : _getUserInfo = getUserInfo,
        _changeName = changeName,
        _changeGender = changeGender,
        _changeMobileNumber = changeMobileNumber,
        _changeNationality = changeNationality,
        _changeBirthDate = changeBirthDate,
        _changeAddress = changeAddress,
        _changeProfessionalTitle = changeProfessionalTitle,
        _changeProfileImage = changeProfileImage,
        _changeCoverImage = changeCoverImage,
        _getUserJobRecruitments = getUserJobRecruitments,
        super(UserInitial()) {
    on<UserEvent>((_, emit) => emit(UserLoading()));
    on<UserGetUserInfo>(onUserGetUserInfo);
    on<UserChangeName>(onUserChangeName);
    on<UserChangeGender>(onUserChangeGender);
    on<UserChangeNationality>(onUserChangeNationality);
    on<UserChangeMobileNumber>(onUserChangeMobileNumber);
    on<UserChangeAddress>(onUserChangeAddress);
    on<UserChangeBirthDate>(onUserChangeBirthDate);
    on<UserChangeProfessionalTitle>(onUserChangeProfessionalTitle);
    on<UserChangeProfileImage>(onUserChangeProfileImage);
    on<UserChangeCoverImage>(onUserChangeCoverImage);
    on<UserGetUserJobRecruitments>(onUserGetUserJobRecruitments);
  }

  void onUserGetUserInfo(UserGetUserInfo event, Emitter<UserState> emit) async {
    final response =
        await _getUserInfo.call(GetUserInfoParams(user_id: event.user_id));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (user) => emit(UserSuccess(user)));
  }

  void onUserChangeName(UserChangeName event, Emitter<UserState> emit) async {
    final response = await _changeName.call(ChangeNameParams(name: event.name));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeNameSuccess()));
  }

  void onUserChangeGender(
      UserChangeGender event, Emitter<UserState> emit) async {
    final response =
        await _changeGender.call(ChangeGenderParams(gender: event.gender));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeGenderSuccess()));
  }

  void onUserChangeNationality(
      UserChangeNationality event, Emitter<UserState> emit) async {
    final response = await _changeNationality
        .call(ChangeNationalityParams(nationality: event.nationality));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeNationalitySuccess()));
  }

  void onUserChangeMobileNumber(
      UserChangeMobileNumber event, Emitter<UserState> emit) async {
    final response = await _changeMobileNumber
        .call(ChangeMobileNumberParams(mobileNumber: event.mobile_number));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeMobileNumberSuccess()));
  }

  void onUserChangeAddress(
      UserChangeAddress event, Emitter<UserState> emit) async {
    final response =
        await _changeAddress.call(ChangeAddressParams(address: event.address));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeAddressSuccess()));
  }

  void onUserChangeBirthDate(
      UserChangeBirthDate event, Emitter<UserState> emit) async {
    final response = await _changeBirthDate
        .call(ChangeBirthDateParams(birthDate: event.birth_date));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeBirthDateSuccess()));
  }

  void onUserChangeProfessionalTitle(
      UserChangeProfessionalTitle event, Emitter<UserState> emit) async {
    final response = await _changeProfessionalTitle.call(
        ChangeProfessionalTitleParams(
            professional_title: event.prefessional_title));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeProfessionalTitleSuccess()));
  }

  void onUserChangeProfileImage(
      UserChangeProfileImage event, Emitter<UserState> emit) async {
    final response = await _changeProfileImage
        .call(ChangeProfileImageParams(image_file: event.image_file));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeProfileImageSuccess()));
  }

  void onUserChangeCoverImage(
      UserChangeCoverImage event, Emitter<UserState> emit) async {
    final response = await _changeCoverImage
        .call(ChangeCoverImageParams(image_file: event.image_file));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeCoverImageSuccess()));
  }

  void onUserGetUserJobRecruitments(
      UserGetUserJobRecruitments event, Emitter<UserState> emit) async {
    final response = await _getUserJobRecruitments
        .call(GetUserJobRecruitmentsParams(user_id: event.user_id));

    response.fold(
        (failure) => emit(UserFailure(failure.message)),
        (jobRecruitments) =>
            emit(UserGetUserJobRecruitmentsSuccess(jobRecruitments)));
  }
}
