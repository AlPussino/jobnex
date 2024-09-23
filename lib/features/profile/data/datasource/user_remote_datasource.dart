import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:JobNex/core/error/exception.dart';
import 'package:JobNex/core/util/upload_image_to_fire_storage.dart';
import 'package:JobNex/features/profile/data/model/work_experience.dart';

abstract interface class UserRemoteDataSource {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      {required String user_id});
  Stream<QuerySnapshot<Map<String, dynamic>>> getWorkExperiences(
      {required String user_id});
  Stream<DocumentSnapshot<Map<String, dynamic>>> getWorkExperienceById(
      {required String user_id, required String workexperience_id});
  Future<void> addWorkExperience({required WorkExperience workExperience});
  Future changeCompanyName({
    required String workExperience_id,
    required String company_name,
  });
  Future changeJobPosition({
    required String workExperience_id,
    required String job_position,
  });
  Future changeJobLocation({
    required String workExperience_id,
    required String job_location,
  });
  Future changeJobType({
    required String workExperience_id,
    required String job_type,
  });
  Future changeWorkExperiencesDates({
    required String workExperience_id,
    required String start_date,
    required String stop_date,
    required bool still_working,
  });
  Future changeName({required String name});
  Future changeGender({required String gender});
  Future changeNationality({required String nationality});
  Future changeMobileNumber({required String mobileNumber});
  Future changeAddress({required String address});
  Future changeBirthDate({required String birthDate});
  Future changeProfessionalTitle({required String professionalTitle});
  Future changeProfileImage({required File imageFile});
  Future changeCoverImage({required File imageFile});
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserJobRecruitments({
    required String user_id,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
    required this.firebaseStorage,
  });

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      {required String user_id}) {
    try {
      return fireStore.collection("users").doc(user_id).snapshots();
      // .map((event) => UserModel.fromJson(event.data()!.cast()));
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getWorkExperiences(
      {required String user_id}) {
    try {
      return fireStore
          .collection("users")
          .doc(user_id)
          .collection("work_experiences")
          .snapshots();
      // .map((snapshot) => snapshot.docs
      //     .map((doc) => WorkExperience.fromJson(doc.data().cast()))
      //     .toList());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future<void> addWorkExperience(
      {required WorkExperience workExperience}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("work_experiences")
          .add(workExperience.toJson());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeCompanyName({
    required String workExperience_id,
    required String company_name,
  }) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("work_experiences")
          .doc(workExperience_id)
          .update({
        "company_name": company_name,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeJobLocation(
      {required String workExperience_id, required String job_location}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("work_experiences")
          .doc(workExperience_id)
          .update({
        "job_location": job_location,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeJobPosition(
      {required String workExperience_id, required String job_position}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("work_experiences")
          .doc(workExperience_id)
          .update({
        "job_position": job_position,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeJobType(
      {required String workExperience_id, required String job_type}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("work_experiences")
          .doc(workExperience_id)
          .update({
        "job_type": job_type,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeWorkExperiencesDates({
    required String workExperience_id,
    required String start_date,
    required String stop_date,
    required bool still_working,
  }) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("work_experiences")
          .doc(workExperience_id)
          .update({
        "start_date": start_date,
        "stop_date": stop_date,
        "still_working": still_working,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeAddress({required String address}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "address": address,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeGender({required String gender}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "gender": gender,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeMobileNumber({required String mobileNumber}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "mobile_number": mobileNumber,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeNationality({required String nationality}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "nationality": nationality,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeName({required String name}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "name": name,
      }).then(
        (value) async {
          await fireAuth.currentUser!.updateDisplayName(name);
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeBirthDate({required String birthDate}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "birth_date": birthDate,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeProfessionalTitle({required String professionalTitle}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "professional_title": professionalTitle,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeProfileImage({required File imageFile}) async {
    try {
      await UploadImageToFireStorage(
              imageFile: imageFile,
              ref: "profileImages/${fireAuth.currentUser!.uid}",
              firebaseStorage: firebaseStorage)
          .then(
        (value) async {
          await fireStore
              .collection("users")
              .doc(fireAuth.currentUser!.uid)
              .update({
            "profile_url": value,
          });
          await fireAuth.currentUser!.updatePhotoURL(value);
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future changeCoverImage({required File imageFile}) async {
    try {
      await UploadImageToFireStorage(
              imageFile: imageFile,
              ref: "coverImages/${fireAuth.currentUser!.uid}",
              firebaseStorage: firebaseStorage)
          .then(
        (value) async {
          await fireStore
              .collection("users")
              .doc(fireAuth.currentUser!.uid)
              .update({
            "cover_url": value,
          });
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserJobRecruitments({
    required String user_id,
  }) {
    try {
      return fireStore
          .collection("recruitments")
          .where("recruiter_id", isEqualTo: user_id)
          .snapshots(includeMetadataChanges: false);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getWorkExperienceById(
      {required String user_id, required String workexperience_id}) {
    try {
      return fireStore
          .collection("users")
          .doc(user_id)
          .collection("work_experiences")
          .doc(workexperience_id)
          .snapshots();
      // .map((snapshot) => snapshot.docs
      //     .map((doc) => WorkExperience.fromJson(doc.data().cast()))
      //     .toList());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
