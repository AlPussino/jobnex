// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_example/core/common/constant/constant.dart';
import 'package:freezed_example/core/error/exception.dart';
import 'package:freezed_example/core/util/get_current_address.dart';
import 'package:freezed_example/core/util/get_current_location.dart';
import 'package:freezed_example/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential?> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<UserCredential?> logInWithEmailPassword(
      {required String email, required String password});
  Future<void> logOut();
}

//

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  final FirebaseStorage fireStorage;
  const AuthRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
    required this.fireStorage,
  });

  @override
  Future<UserCredential?> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await fireAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user.user!.updateDisplayName(name);
      String? fcmToken = await fireMessage.getToken();
      await user.user!.updatePhotoURL(Constant.defaultAvater);
      final currentLocation = await getCurrentLocation();
      final currentAddress = await getCurrentAddress(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);

      final userModel = UserModel(
        user_id: fireAuth.currentUser!.uid,
        name: name,
        email: email,
        mobile_number: Constant.unknown,
        gender: Constant.unknown,
        birth_date: DateTime.now(),
        professional_title: Constant.unknown,
        nationality: Constant.unknown,
        skill: [],
        fcm_token: fcmToken!,
        is_online: true,
        last_online: DateTime.now(),
        in_chat: true,
        profile_url: Constant.defaultAvater,
        cover_url: Constant.defaultAvater,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        address: currentAddress,
      );

      // final workExperience = WorkExperience(
      //     job_experience_id: const Uuid().v1(),
      //     job_position: "Flutter Developer",
      //     job_location: "Yangon",
      //     company_name: "Digitalbase",
      //     start_date: DateTime.now(),
      //     stop_date: DateTime.now(),
      //     still_working: true,
      //     job_type: "Full Time");

      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .set(userModel.toJson());

      // await fireStore
      //     .collection("users")
      //     .doc(fireAuth.currentUser!.uid)
      //     .collection("work_experiences")
      //     .add(workExperience.toJson());

      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future<UserCredential?> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await fireAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
