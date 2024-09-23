import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:JobNex/features/auth/presentation/pages/sign_up_page.dart';
import 'package:JobNex/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:JobNex/core/common/widget/text_form_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/features/bottom_navigation_bar_page.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login-page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final size = MediaQuery.sizeOf(context);

    void login() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(AuthLogIn(
            email: emailController.text, password: passwordController.text));
      }
    }

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          log(orientation.name);

          return orientation == Orientation.portrait
              ? LogInPagePortrait(
                  formKey: formKey,
                  size: size,
                  emailController: emailController,
                  passwordController: passwordController,
                  login: login,
                )
              : LogInPageLandscape(
                  formKey: formKey,
                  size: size,
                  emailController: emailController,
                  passwordController: passwordController,
                  login: login,
                );
        },
      ),
    );
  }
}

class LogInPagePortrait extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback login;

  const LogInPagePortrait({
    super.key,
    required this.formKey,
    required this.size,
    required this.emailController,
    required this.passwordController,
    required this.login,
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
              Navigator.pushReplacementNamed(
                  context, BottomNavigationBarPage.routeName);
              SnackBars.showToastification(
                  context, "login success.", ToastificationType.success);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingWidget();
            }
            return ListView(
              children: [
                const Text("Login."),
                SizedBox(height: size.height / 10),
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
                  buttonName: "Login",
                  onPressed: login,
                ),
                SizedBox(height: size.height / 10),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SignUpPage.routeName),
                  child: const Text("You don't have an account?. Sign up."),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LogInPageLandscape extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback login;

  const LogInPageLandscape({
    super.key,
    required this.formKey,
    required this.size,
    required this.emailController,
    required this.passwordController,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              SnackBars.showToastification(
                  context, state.message, ToastificationType.error);
            }
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(
                  context, BottomNavigationBarPage.routeName);
              SnackBars.showToastification(
                  context, "login success.", ToastificationType.success);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingWidget();
            }
            return Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Login.",
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
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
                        buttonName: "Login",
                        onPressed: login,
                      ),
                      SizedBox(height: size.height / 10),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, SignUpPage.routeName),
                        child:
                            const Text("You don't have an account?. Sign up."),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
