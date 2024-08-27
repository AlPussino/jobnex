import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/auth/presentation/provider/sign_up_page_provider.dart';
import 'package:freezed_example/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:freezed_example/features/bottom_navigation_bar_page.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/common/widget/text_form_fields.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/sign-up-page';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final size = MediaQuery.sizeOf(context);

    void signUp() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(AuthSignUp(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            ));
      } else {
        log("Not validated");
      }
    }

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => SignUpPageProvider(),
        builder: (context, child) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? SignUpPagePortrait(
                      formKey: formKey,
                      size: size,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      signUp: signUp,
                    )
                  : SignUpLandscape(
                      formKey: formKey,
                      size: size,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      signUp: signUp,
                    );
            },
          );
        },
      ),
    );
  }
}

class SignUpPagePortrait extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback signUp;

  const SignUpPagePortrait({
    super.key,
    required this.formKey,
    required this.size,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              SnackBars.showToastification(
                  context, state.message, ToastificationType.error);
            }
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomNavigationBarPage.routeName, (route) => false);
              SnackBars.showToastification(context, "Creating account success.",
                  ToastificationType.success);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingWidget(
                caption: "Creating account...",
              );
            }

            return ListView(
              children: [
                Text(
                  "Sign Up.",
                  style: Theme.of(context).primaryTextTheme.headlineLarge,
                ),
                SizedBox(height: size.height / 10),
                TextFormFields(
                  hintText: "Name",
                  controller: nameController,
                  isObscureText: false,
                ),
                SizedBox(height: size.height / 30),
                TextFormFields(
                  hintText: "Email",
                  controller: emailController,
                  isObscureText: false,
                ),
                SizedBox(height: size.height / 30),
                TextFormFields(
                  hintText: "Password",
                  controller: passwordController,
                  isObscureText: true,
                ),
                SizedBox(height: size.height / 25),
                ElevatedButtons(
                  buttonName: "Sign Up",
                  onPressed: signUp,
                ),
                SizedBox(height: size.height / 10),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).primaryTextTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: AppPallete
                                          .elevatedButtonBackgroundColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SignUpLandscape extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback signUp;
  const SignUpLandscape({
    super.key,
    required this.formKey,
    required this.size,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              SnackBars.showToastification(
                  context, state.message, ToastificationType.error);
            }
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomNavigationBarPage.routeName, (route) => false);
              SnackBars.showToastification(context, "Creating account success.",
                  ToastificationType.success);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingWidget(
                caption: "Creating account...",
              );
            }
            return Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up.",
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    TextFormFields(
                      hintText: "Name",
                      controller: nameController,
                      isObscureText: false,
                    ),
                    SizedBox(height: size.height / 30),
                    TextFormFields(
                      hintText: "Email",
                      controller: emailController,
                      isObscureText: false,
                    ),
                    SizedBox(height: size.height / 30),
                    TextFormFields(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    SizedBox(height: size.height / 25),
                    ElevatedButtons(
                      buttonName: "Sign Up",
                      onPressed: signUp,
                    ),
                    SizedBox(height: size.height / 10),
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppPallete
                                              .elevatedButtonBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
