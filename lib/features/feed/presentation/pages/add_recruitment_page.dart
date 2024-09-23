import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:JobNex/core/common/widget/text_form_fields.dart';
import 'package:JobNex/features/feed/data/model/job_recruitment.dart';
import 'package:JobNex/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:toastification/toastification.dart';

class AddRecruitmentPage extends StatelessWidget {
  static const routeName = '/add-recruitment-page';

  const AddRecruitmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final companyNameController = TextEditingController();
    final jobPositionController = TextEditingController();
    final aboutTheOppotunityController = TextEditingController();
    final roleResponsibilityController = TextEditingController();
    final skillsController = TextEditingController();
    final jobLocationController = TextEditingController();
    final jobTypeController = TextEditingController();
    final yearsOfExperienceController = TextEditingController();
    final sallaryRangeController = TextEditingController();
    final size = MediaQuery.sizeOf(context);

    void addRecruitment() {
      final fireAuth = FirebaseAuth.instance;
      if (formKey.currentState!.validate()) {
        final jobRecruitment = JobRecruitment(
          company_name: companyNameController.text,
          job_position: jobPositionController.text,
          job_location: jobLocationController.text,
          job_type: jobTypeController.text,
          about_the_oppotunity: aboutTheOppotunityController.text,
          role_responsibility: roleResponsibilityController.text,
          skills: skillsController.text,
          years_of_experience: yearsOfExperienceController.text,
          sallary_range: sallaryRangeController.text,
          recruiter_id: fireAuth.currentUser!.uid,
          candidates: [],
          created_at: DateTime.now(),
        );

        context.read<FeedBloc>().add(FeedAddJobRecruitment(jobRecruitment));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Add Recruitment")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: BlocConsumer<FeedBloc, FeedState>(
            listener: (context, state) {
              if (state is FeedFailure) {
                SnackBars.showToastification(
                    context, state.message, ToastificationType.error);
              }
              if (state is FeedAddJobRecruitmentSuccessState) {
                SnackBars.showToastification(
                    context,
                    "Adding job recruitment successfully.",
                    ToastificationType.success);
                Navigator.pop(context);
                // context.read<FeedBloc>().add(FeedGetAllJobRecruitments());
              }
            },
            builder: (context, state) {
              if (state is FeedLoading) {
                return const LoadingWidget();
              }
              return ListView(
                children: [
                  TextFormFields(
                      hintText: "Company Name",
                      controller: companyNameController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Job Position",
                      controller: jobPositionController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Job Location",
                      controller: jobLocationController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Job Type",
                      controller: jobTypeController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "About the oppotunity",
                      controller: aboutTheOppotunityController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Role responsibilities",
                      controller: roleResponsibilityController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Skills",
                      controller: skillsController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Years of Experiences",
                      controller: yearsOfExperienceController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                      hintText: "Sallary Range",
                      controller: sallaryRangeController,
                      isObscureText: false),
                  SizedBox(height: size.height / 30),
                  ElevatedButtons(
                      buttonName: "Add recruitment", onPressed: addRecruitment),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
