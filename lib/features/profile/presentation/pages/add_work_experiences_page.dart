import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:freezed_example/core/common/widget/text_form_fields.dart';
import 'package:freezed_example/features/profile/data/model/work_experience.dart';
import 'package:freezed_example/features/profile/presentation/bloc/work_experience_bloc.dart';
import 'package:freezed_example/features/profile/presentation/widgets/work_experiences_dates.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class AddWorkExperiencePage extends StatefulWidget {
  static const routeName = '/add-work-experience-page';

  const AddWorkExperiencePage({
    super.key,
  });

  @override
  State<AddWorkExperiencePage> createState() => _AddWorkExperiencePageState();
}

class _AddWorkExperiencePageState extends State<AddWorkExperiencePage> {
  final formKey = GlobalKey<FormState>();
  final jobPositionController = TextEditingController();
  final jobLocationController = TextEditingController();
  final companyController = TextEditingController();
  final startDateController = TextEditingController();
  final stopDateController = TextEditingController();
  final jobTypeController = TextEditingController();
  bool stillWorking = true;
  DateTime? startDate;
  DateTime? stopTime;
  final user_id = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    jobPositionController.dispose();
    jobLocationController.dispose();
    jobTypeController.dispose();
    companyController.dispose();
    startDateController.dispose();
    stopDateController.dispose();
    super.dispose();
  }

  void addNewWorkExperience() {
    final job_id = const Uuid().v1();
    final newWorkExperience = WorkExperience(
      job_experience_id: job_id,
      job_position: jobPositionController.text,
      job_location: jobLocationController.text,
      company_name: companyController.text,
      start_date: DateTime.parse(startDateController.text),
      stop_date: stillWorking
          ? DateTime.now()
          : DateTime.parse(stopDateController.text),
      still_working: stillWorking,
      job_type: jobTypeController.text,
    );
    context
        .read<WorkExperienceBloc>()
        .add(WorkExperienceAddWorkExperience(newWorkExperience));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Wrok Experience"),
      ),
      body: Form(
        key: formKey,
        child: BlocConsumer<WorkExperienceBloc, WorkExperienceState>(
          listener: (context, state) {
            if (state is WorkExperienceFailure) {
              SnackBars.showToastification(
                  context, state.message, ToastificationType.error);
            }
            if (state is WorkExperienceAddWorkExperienceSuccess) {
              Navigator.pop(context, true);
              SnackBars.showToastification(context,
                  "New Work Experience added.", ToastificationType.success);
            }
          },
          builder: (context, state) {
            if (state is WorkExperienceLoading) {
              return const LoadingWidget();
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  TextFormFields(
                    hintText: "Job Position",
                    controller: jobPositionController,
                    isObscureText: false,
                  ),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                    hintText: "Job Location",
                    controller: jobLocationController,
                    isObscureText: false,
                  ),
                  SizedBox(height: size.height / 30),
                  TextFormFields(
                    hintText: "Company Name",
                    controller: companyController,
                    isObscureText: false,
                  ),
                  SizedBox(height: size.height / 30),

                  TextFormFields(
                    hintText: "Full Time (or) Part Time",
                    controller: jobTypeController,
                    isObscureText: false,
                  ),
                  SizedBox(height: size.height / 30),

                  ///
                  WorkExperienceDates(
                    dateController: startDateController,
                    hintText: "Start Date",
                  ),
                  //
                  SizedBox(height: size.height / 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Still working"),
                      Switch(
                        value: stillWorking,
                        onChanged: (value) {
                          setState(() {
                            stillWorking = value;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: size.height / 30),

                  ///
                  stillWorking
                      ? const SizedBox()
                      : WorkExperienceDates(
                          dateController: stopDateController,
                          hintText: "Stop Date",
                        ),

                  SizedBox(height: size.height / 30),
                  ElevatedButtons(
                    buttonName: "Add",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log("validted");
                        addNewWorkExperience();
                      } else {
                        log("Not validated");
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
