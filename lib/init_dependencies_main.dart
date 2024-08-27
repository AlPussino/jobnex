import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_example/core/network/connection_checker.dart';
import 'package:freezed_example/features/applied_jobs/data/datasource/applied_jobs_remote_datasource.dart';
import 'package:freezed_example/features/applied_jobs/data/repository/applied_jobs_repository_impl.dart';
import 'package:freezed_example/features/applied_jobs/domain/repository/applied_jobs_repository.dart';
import 'package:freezed_example/features/applied_jobs/domain/usercase/get_user_applied_jobs.dart';
import 'package:freezed_example/features/applied_jobs/presentation/bloc/applied_jobs_bloc.dart';
import 'package:freezed_example/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:freezed_example/features/auth/data/respoitory/auth_repository_impl.dart';
import 'package:freezed_example/features/auth/domain/repository/auth_repository.dart';
import 'package:freezed_example/features/auth/domain/usecase/log_in_with_email_and_password.dart';
import 'package:freezed_example/features/auth/domain/usecase/log_out.dart';
import 'package:freezed_example/features/auth/domain/usecase/sign_up_with_email_and_password.dart';
import 'package:freezed_example/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:freezed_example/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:freezed_example/features/chat/data/repository/chat_repository_impl.dart';
import 'package:freezed_example/features/chat/domain/repository/chat_repository.dart';
import 'package:freezed_example/features/chat/domain/usecase/block_user.dart';
import 'package:freezed_example/features/chat/domain/usecase/create_chat.dart';
import 'package:freezed_example/features/chat/domain/usecase/delete_conversation.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_chat_list.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_chat_stream.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_chatroom_data.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_files_in_chat.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_images_in_chat.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_videos_in_chat.dart';
import 'package:freezed_example/features/chat/domain/usecase/get_voices_in_chat.dart';
import 'package:freezed_example/features/chat/domain/usecase/send_file_message.dart';
import 'package:freezed_example/features/chat/domain/usecase/send_text_message.dart';
import 'package:freezed_example/features/chat/domain/usecase/update_quick_reaction.dart';
import 'package:freezed_example/features/chat/domain/usecase/update_theme.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/feed/data/datasource/feed_remote_datasource.dart';
import 'package:freezed_example/features/feed/data/repository/feed_repository_impl.dart';
import 'package:freezed_example/features/feed/domain/repository/feed_repository.dart';
import 'package:freezed_example/features/feed/domain/usecase/add_job_recruitment.dart';
import 'package:freezed_example/features/feed/domain/usecase/apply_job.dart';
import 'package:freezed_example/features/feed/domain/usecase/get_all_job_recruitments.dart';
import 'package:freezed_example/features/feed/domain/usecase/get_candidates.dart';
import 'package:freezed_example/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:freezed_example/features/post/data/datasource/post_remote_datasource.dart';
import 'package:freezed_example/features/post/data/repository/post_repository_impl.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';
import 'package:freezed_example/features/post/domain/usecase/add_post.dart';
import 'package:freezed_example/features/post/domain/usecase/get_all_posts.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:freezed_example/features/profile/data/datasource/user_remote_datasource.dart';
import 'package:freezed_example/features/profile/data/repository/user_repository_impl.dart';
import 'package:freezed_example/features/profile/domain/repository/user_repository.dart';
import 'package:freezed_example/features/profile/domain/usecase/add_work_experience.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_address.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_birth_date.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_company_name.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_cover_image.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_gender.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_job_location.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_job_position.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_job_type.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_mobile_number.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_name.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_nationality.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_professional_title.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_profile_image.dart';
import 'package:freezed_example/features/profile/domain/usecase/change_work_experiences_dates.dart';
import 'package:freezed_example/features/profile/domain/usecase/get_user_info.dart';
import 'package:freezed_example/features/profile/domain/usecase/get_user_job_recruitments.dart';
import 'package:freezed_example/features/profile/domain/usecase/get_work_experience_by_id.dart';
import 'package:freezed_example/features/profile/domain/usecase/get_work_experiences.dart';
import 'package:freezed_example/features/profile/presentation/bloc/user_bloc.dart';
import 'package:freezed_example/features/profile/presentation/bloc/work_experience_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  initFirebase();
  initConnectionChecker();
  initAuth();
  initUser();
  initFeed();
  initPost();
  initAppliedJobs();
  initChat();
}

void initFirebase() {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final fireMessage = FirebaseMessaging.instance;
  final fireStorage = FirebaseStorage.instance;
  serviceLocator.registerLazySingleton(() => fireAuth);
  serviceLocator.registerLazySingleton(() => fireStore);
  serviceLocator.registerLazySingleton(() => fireMessage);
  serviceLocator.registerLazySingleton(() => fireStorage);
}

void initConnectionChecker() {
  serviceLocator.registerFactory(() => InternetConnectionChecker());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

void initAuth() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
          fireAuth: serviceLocator(),
          fireMessage: serviceLocator(),
          fireStore: serviceLocator(),
          fireStorage: serviceLocator(),
        ))

    //Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

    //Usecase
    ..registerFactory(() => SignUpWithEmailAndPassword(serviceLocator()))
    ..registerFactory(() => LogInWithEmailAndPassword(serviceLocator()))
    ..registerFactory(() => LogOut(serviceLocator()))

    //Bloc
    ..registerFactory(() => AuthBloc(
          signUpWithEmailAndPassword: serviceLocator(),
          logInWithEmailAndPassword: serviceLocator(),
          logOut: serviceLocator(),
        ));
}

void initUser() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
        fireAuth: serviceLocator(),
        fireStore: serviceLocator(),
        fireMessage: serviceLocator(),
        firebaseStorage: serviceLocator()))

    //Repository
    ..registerFactory<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

    //Usecase
    ..registerFactory(() => GetUserInfo(serviceLocator()))
    ..registerFactory(() => GetWorkExperiences(serviceLocator()))
    ..registerFactory(() => AddWorkExperience(serviceLocator()))
    ..registerFactory(() => GetWorkExperienceById(serviceLocator()))
    ..registerFactory(() => ChangeCompanyName(serviceLocator()))
    ..registerFactory(() => ChangeJobPosition(serviceLocator()))
    ..registerFactory(() => ChangeJobLocation(serviceLocator()))
    ..registerFactory(() => ChangeJobType(serviceLocator()))
    ..registerFactory(() => ChangeWorkExperiencesDates(serviceLocator()))
    ..registerFactory(() => ChangeName(serviceLocator()))
    ..registerFactory(() => ChangeGender(serviceLocator()))
    ..registerFactory(() => ChangeNationality(serviceLocator()))
    ..registerFactory(() => ChangeMobileNumber(serviceLocator()))
    ..registerFactory(() => ChangeAddress(serviceLocator()))
    ..registerFactory(() => ChangeBirthDate(serviceLocator()))
    ..registerFactory(() => ChangeProfessionalTitle(serviceLocator()))
    ..registerFactory(() => ChangeProfileImage(serviceLocator()))
    ..registerFactory(() => ChangeCoverImage(serviceLocator()))
    ..registerFactory(() => GetUserJobRecruitments(serviceLocator()))

    //Bloc
    ..registerFactory(
      () => UserBloc(
        getUserInfo: serviceLocator(),
        changeName: serviceLocator(),
        changeGender: serviceLocator(),
        changeNationality: serviceLocator(),
        changeMobileNumber: serviceLocator(),
        changeAddress: serviceLocator(),
        changeBirthDate: serviceLocator(),
        changeProfessionalTitle: serviceLocator(),
        changeProfileImage: serviceLocator(),
        changeCoverImage: serviceLocator(),
        getUserJobRecruitments: serviceLocator(),
      ),
    )
    ..registerFactory(() => WorkExperienceBloc(
          getWorkExperiences: serviceLocator(),
          getWorkExperienceById: serviceLocator(),
          addWorkExperience: serviceLocator(),
          changeCompanyName: serviceLocator(),
          changeJobPosition: serviceLocator(),
          changeJobLocation: serviceLocator(),
          changeJobType: serviceLocator(),
          changeWorkExperiencesDates: serviceLocator(),
        ));
}

void initFeed() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<FeedRemoteDataSource>(() => FeedRemoteDataSourceImpl(
        fireAuth: serviceLocator(),
        fireStore: serviceLocator(),
        fireMessage: serviceLocator(),
        firebaseStorage: serviceLocator()))

    //Repository
    ..registerFactory<FeedRepository>(() => FeedRepositoryImpl(
        feedRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

    //Usecase
    ..registerFactory(() => AddJobRecruitment(serviceLocator()))
    ..registerFactory(() => GetAllJobRecruitments(serviceLocator()))
    ..registerFactory(() => Applyjob(serviceLocator()))
    ..registerFactory(() => GetCandidates(serviceLocator()))

    //Bloc
    ..registerFactory(() => FeedBloc(
          addJobRecruitment: serviceLocator(),
          getAllJobRecruitments: serviceLocator(),
          applyJob: serviceLocator(),
          getCandidates: serviceLocator(),
        ));
}

void initPost() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(
        fireAuth: serviceLocator(),
        fireStore: serviceLocator(),
        fireMessage: serviceLocator(),
        firebaseStorage: serviceLocator()))

    //Repository
    ..registerFactory<PostRepository>(() => PostRepositoryImpl(
        postRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

    //Usecase
    ..registerFactory(() => AddPost(serviceLocator()))
    ..registerFactory(() => GetAllPosts(serviceLocator()))

    //Bloc
    ..registerFactory(() => PostBloc(
          addPost: serviceLocator(),
          getAllPosts: serviceLocator(),
        ));
}

void initAppliedJobs() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<AppliedJobsRemoteDataSource>(
        () => AppliedJobsRemoteDataSourceImpl(
              fireAuth: serviceLocator(),
              fireStore: serviceLocator(),
              fireMessage: serviceLocator(),
              firebaseStorage: serviceLocator(),
            ))

    //Repository
    ..registerFactory<AppliedJobsRepository>(() => AppliedJobsRepositoryImpl(
        appliedJobsRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

    //Usecase
    ..registerFactory(() => GetUserAppliedJobs(serviceLocator()))

    //Bloc
    ..registerFactory(() => AppliedJobsBloc(
          getUserAppliedJobs: serviceLocator(),
        ));
}

void initChat() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(
        fireAuth: serviceLocator(),
        fireStore: serviceLocator(),
        fireMessage: serviceLocator(),
        firebaseStorage: serviceLocator()))

    //Repository
    ..registerFactory<ChatRepository>(() => ChatRepositoryImpl(
        chatRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

    //Usecase
    ..registerFactory(() => CreateChat(serviceLocator()))
    ..registerFactory(() => GetChatList(serviceLocator()))
    ..registerFactory(() => GetChatStream(serviceLocator()))
    ..registerFactory(() => SendTextMessage(serviceLocator()))
    ..registerFactory(() => SendFileMessage(serviceLocator()))
    ..registerFactory(() => UpdateTheme(serviceLocator()))
    ..registerFactory(() => GetChatroomData(serviceLocator()))
    ..registerFactory(() => UpdateQuickReaction(serviceLocator()))
    ..registerFactory(() => GetImagesInChat(serviceLocator()))
    ..registerFactory(() => GetVideosInChat(serviceLocator()))
    ..registerFactory(() => GetVoicesInChat(serviceLocator()))
    ..registerFactory(() => GetFilesInChat(serviceLocator()))
    ..registerFactory(() => DeleteConversation(serviceLocator()))
    ..registerFactory(() => BlockUser(serviceLocator()))

    //Bloc
    ..registerFactory(() => ChatBloc(
          createChat: serviceLocator(),
          getChatList: serviceLocator(),
          getChatStream: serviceLocator(),
          sendTextMessage: serviceLocator(),
          sendFileMessage: serviceLocator(),
          updateTheme: serviceLocator(),
          getChatRoomData: serviceLocator(),
          updateQuickReaction: serviceLocator(),
          getImagesInChat: serviceLocator(),
          getVideosInChat: serviceLocator(),
          getVoicesInChat: serviceLocator(),
          getFilesInChat: serviceLocator(),
          deleteConversation: serviceLocator(),
          blockUser: serviceLocator(),
        ));
}
