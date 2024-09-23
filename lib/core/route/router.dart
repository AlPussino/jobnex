import 'dart:io';

import 'package:JobNex/features/chat/presentation/pages/preview_and_add_story_page.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/auth_gate.dart';
import 'package:JobNex/core/common/widget/view_image_page.dart';
import 'package:JobNex/core/common/widget/view_images_list_page.dart';
import 'package:JobNex/core/common/widget/view_video_page.dart';
import 'package:JobNex/features/auth/presentation/pages/fill_information_page.dart';
import 'package:JobNex/features/auth/presentation/pages/login_page.dart';
import 'package:JobNex/features/auth/presentation/pages/sign_up_page.dart';
import 'package:JobNex/features/bottom_navigation_bar_page.dart';
import 'package:JobNex/features/chat/data/model/story_body.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_conversation_page.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_information_page.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_page.dart';
import 'package:JobNex/features/applied_jobs/presentation/pages/applied_jobs_page.dart';
import 'package:JobNex/features/chat/presentation/pages/photos_page.dart';
import 'package:JobNex/features/chat/presentation/pages/select_photos_page.dart';
import 'package:JobNex/features/chat/presentation/pages/select_videos_page.dart';
import 'package:JobNex/features/chat/presentation/pages/update_quick_reaction_page.dart';
import 'package:JobNex/features/chat/presentation/pages/update_theme_page.dart';
import 'package:JobNex/features/chat/presentation/pages/view_media_page.dart';
import 'package:JobNex/features/chat/presentation/pages/view_story_page.dart';
import 'package:JobNex/features/feed/presentation/pages/add_recruitment_page.dart';
import 'package:JobNex/features/feed/presentation/pages/feed_page.dart';
import 'package:JobNex/features/feed/presentation/pages/job_recruitment_detail_page.dart';
import 'package:JobNex/features/post/presentation/pages/add_post_page.dart';
import 'package:JobNex/features/post/presentation/pages/comment_list_page.dart';
import 'package:JobNex/features/post/presentation/pages/post_detail_page.dart';
import 'package:JobNex/features/post/presentation/pages/post_page.dart';
import 'package:JobNex/features/post/presentation/pages/reacts_owners_list_page.dart';
import 'package:JobNex/features/profile/presentation/pages/add_work_experiences_page.dart';
import 'package:JobNex/features/profile/presentation/pages/change_contacts.page.dart';
import 'package:JobNex/features/profile/presentation/pages/change_work_experiences_dates_page.dart';
import 'package:JobNex/features/profile/presentation/pages/profile_page.dart';
import 'package:JobNex/features/profile/presentation/pages/work_experience.detail_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/post/data/model/post.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Auth Gate Screen
    case AuthGate.routeName:
      return PageTransition(
        child: const AuthGate(),
        type: PageTransitionType.rightToLeft,
        fullscreenDialog: true,
        duration: const Duration(milliseconds: 300),
      );
    // Login Screen
    case LoginPage.routeName:
      return PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.rightToLeft,
        fullscreenDialog: true,
        duration: const Duration(milliseconds: 300),
      );

    // Sign Up Screen
    case SignUpPage.routeName:
      return PageTransition(
          child: const SignUpPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Fill Information Screen=
    case FillInformationPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final email = arguments['email'];
      final mobileNumber = arguments['mobileNumber'];
      final password = arguments['password'];
      final country = arguments['country'];
      final professionalTitle = arguments['professionalTitle'];
      return PageTransition(
          child: FillInformationPage(
              name: name,
              email: email,
              mobileNumber: mobileNumber,
              password: password,
              country: country,
              professionalTitle: professionalTitle),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Bottom Navigation Bar Screen
    case BottomNavigationBarPage.routeName:
      return PageTransition(
          child: const BottomNavigationBarPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Feed Screen
    case FeedPage.routeName:
      return PageTransition(
          child: const FeedPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Profile Screen
    case ProfilePage.routeName:
      final user_id = routeSettings.arguments as String;
      return PageTransition(
          child: ProfilePage(user_id: user_id),
          type: PageTransitionType.topToBottom,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Add Work Experience Screen
    case AddWorkExperiencePage.routeName:
      return PageTransition(
          child: const AddWorkExperiencePage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Add Work Experience Detail Screen
    case WorkExperienceDetailPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final workExperience = arguments['workExperience'];
      final user_id = arguments['user_id'];
      return PageTransition(
          child: WorkExperienceDetailPage(
              workExperience_id: workExperience, user_id: user_id),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Change Work Experiences Dates Screen
    case ChangeWorkExperiencesDatesPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final workExperience = arguments['workExperience'];
      final workExperience_id = arguments['workExperience_id'];
      return PageTransition(
          child: ChangeWorkExperiencesDatesPage(
            workExperience: workExperience,
            workExperience_id: workExperience_id,
          ),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Change Contacts Screen
    case ChangeContactsPage.routeName:
      final contacts = routeSettings.arguments as Map<String, dynamic>;
      return PageTransition(
          child: ChangeContactsPage(contacts: contacts),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // View Image Screen
    case ViewImagePage.routeName:
      final image = routeSettings.arguments as String;
      return PageTransition(
        child: ViewImagePage(image: image),
        type: PageTransitionType.theme,
        alignment: Alignment.bottomCenter,
        fullscreenDialog: true,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
      );

    // Add Recruitment Screen
    case AddRecruitmentPage.routeName:
      return PageTransition(
          child: const AddRecruitmentPage(),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Job Recruitment Detail Screen
    case JobRecruitmentDetailPage.routeName:
      final argumants = routeSettings.arguments as Map<String, dynamic>;
      final jobRecruitmentData = argumants['jobRecruitmentData'];
      final jobRecruitmentId = argumants['jobRecruitmentId'];
      return PageTransition(
          child: JobRecruitmentDetailPage(
            JobRecruitmentData: jobRecruitmentData,
            jobRecruitmentId: jobRecruitmentId,
          ),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Applied Jobs Screen
    case AppliedJobsPage.routeName:
      return PageTransition(
          child: const AppliedJobsPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Favorite Screen
    case ChatPage.routeName:
      return PageTransition(
          child: const ChatPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Chat Conversation Screen
    case ChatConversationPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final receiverData = arguments['receiverData'];
      final chatRoomId = arguments['chatRoomId'];
      return PageTransition(
          child: ChatConversationPage(
              receiverData: receiverData, chatRoomId: chatRoomId),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // View Images List Screen
    case ViewImagesListPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final images = arguments['images'];
      final id = arguments['id'];
      final isOwner = arguments['isOwner'];
      return PageTransition(
          child: ViewImagesListPage(images: images, id: id, isOwner: isOwner),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Select Photos Screen
    case SelectPhotosPage.routeName:
      final receiverData = routeSettings.arguments as Map<String, dynamic>;
      return PageTransition(
          child: SelectPhotosPage(receiverData: receiverData),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Select Videos Screen
    case SelectVideosPage.routeName:
      final receiverData = routeSettings.arguments as Map<String, dynamic>;
      return PageTransition(
          child: SelectVideosPage(receiverData: receiverData),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Photos Screen
    case PhotosPage.routeName:
      return PageTransition(
          child: const PhotosPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Chat Information Screen
    case ChatInformationPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final receiverData = arguments['receiverData'];
      final chatRoomId = arguments['chatRoomId'];
      final chatRoomData = arguments['chatRoomData'];
      return PageTransition(
          child: ChatInformationPage(
            chatRoomData: chatRoomData,
            receiverData: receiverData,
            chatRoomId: chatRoomId,
          ),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Update Theme Screen
    case UpdateThemePage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final receiverData = arguments['receiverData'];
      final chatListData = arguments['chatListData'];
      return PageTransition(
          child: UpdateThemePage(
              receiverData: receiverData, chatListData: chatListData),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Update Quick Reaction Screen
    case UpdateQuickReactionPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final receiverData = arguments['receiverData'];
      final chatListData = arguments['chatListData'];
      return PageTransition(
          child: UpdateQuickReactionPage(
              receiverData: receiverData, chatListData: chatListData),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // View Media Screen
    case ViewMediaPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final chatRoomId = arguments['chatRoomId'];
      final chatRoomData = arguments['chatRoomData'];
      return PageTransition(
          child: ViewMediaPage(
            chatRoomId: chatRoomId,
            chatRoomData: chatRoomData,
          ),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // View Videp Screen
    case ViewVideoPage.routeName:
      final video_url = routeSettings.arguments as String;
      return PageTransition(
          child: ViewVideoPage(videoUrl: video_url),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Post Screen
    case PostPage.routeName:
      return PageTransition(
          child: const PostPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Post Detail Screen
    case PostDetailPage.routeName:
      final post_id = routeSettings.arguments as String;
      return PageTransition(
          child: PostDetailPage(post_id: post_id),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    //  Add Post Screen
    case AddPostPage.routeName:
      return PageTransition(
          child: const AddPostPage(),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    //  Comment List Screen
    case CommentListPage.routeName:
      final post = routeSettings.arguments as Post;
      return PageTransition(
          child: CommentListPage(post: post),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    //  Reacts Owners List Screen
    case ReactsOwnersListPage.routeName:
      final post = routeSettings.arguments as Post;
      return PageTransition(
          child: ReactsOwnersListPage(post: post),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    //  View Story Screen
    case ViewStoryPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      List<StoryBody> storyBodies = arguments['story_bodies'];
      String story_owner_name = arguments['story_owner_name'];
      String story_owner_profile = arguments['story_owner_profile'];
      return PageTransition(
          child: ViewStoryPage(
            storyBodies: storyBodies,
            story_owner_name: story_owner_name,
            story_owner_profile: story_owner_profile,
          ),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

   
    // Preview And Add Story Screen
    case PreviewAndAddStoryPage.routeName:
      final imageFile = routeSettings.arguments as File;
      return PageTransition(
          child: PreviewAndAddStoryPage(imageFile: imageFile),
          type: PageTransitionType.bottomToTop,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 300));

    // Defaut Screen
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("Not Existed")));
  }
}
