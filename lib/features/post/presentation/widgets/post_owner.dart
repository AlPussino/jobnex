import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/profile/presentation/bloc/user_bloc.dart';
import 'package:toastification/toastification.dart';

class PostOwner extends StatefulWidget {
  final String post_owner_id;
  final String created_at;
  const PostOwner(
      {super.key, required this.post_owner_id, required this.created_at});

  @override
  State<PostOwner> createState() => _PostOwnerState();
}

class _PostOwnerState extends State<PostOwner> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserGetUserInfo(widget.post_owner_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listenWhen: (previous, current) => current is UserFailure,
      buildWhen: (previous, current) => current is UserSuccess,
      listener: (context, state) {
        if (state is UserFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        // Loading
        if (state is UserLoading) {
          return const LoadingWidget();
        }

        // Failure
        if (state is UserFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }

        // Success
        if (state is UserSuccess) {
          return StreamBuilder(
            stream: state.userInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasError) {
                return ErrorWidgets(errorMessage: "${snapshot.error}");
              }
              final user = snapshot.data!.data()!;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(user['profile_url'])),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${user['name']}"),
                          Text(widget.created_at),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              );
            },
          );
        }
        return const ErrorWidgets(errorMessage: "No active state.");
      },
    );
  }
}
