import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/change_date_format.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:freezed_example/features/profile/presentation/bloc/work_experience_bloc.dart';
import 'package:freezed_example/features/profile/presentation/widgets/work_experiences_dates.dart';
import 'package:toastification/toastification.dart';

class ChangeWorkExperiencesDatesPage extends StatefulWidget {
  static const routeName = '/change-work-experiences-dates-page';
  final Map<String, dynamic> workExperience;
  final String workExperience_id;
  const ChangeWorkExperiencesDatesPage({
    super.key,
    required this.workExperience,
    required this.workExperience_id,
  });

  @override
  State<ChangeWorkExperiencesDatesPage> createState() =>
      _ChangeWorkExperiencesDatesPageState();
}

class _ChangeWorkExperiencesDatesPageState
    extends State<ChangeWorkExperiencesDatesPage> {
  final formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController();
  final stopDateController = TextEditingController();
  bool stillWorking = true;
  DateTime? startDate;
  DateTime? stopTime;
  final fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    startDateController.text = widget.workExperience["start_date"];
    stopDateController.text = DateTime.now().toString();
    super.initState();
  }

  @override
  void dispose() {
    startDateController.dispose();
    stopDateController.dispose();
    super.dispose();
  }

  void changeWorkExperiencesDates() {
    if (stillWorking) {
      stopDateController.text = DateTime.now().toString();
    }
    context
        .read<WorkExperienceBloc>()
        .add(WorkExperienceChangeWorkExperiencesDates(
          widget.workExperience_id,
          startDateController.text,
          stopDateController.text,
          stillWorking,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start date & End date"),
      ),
      body: BlocConsumer<WorkExperienceBloc, WorkExperienceState>(
        listener: (context, state) {
          if (state is WorkExperienceFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is WorkExperienceChangeWorkExperiencesDatesSuccess) {
            SnackBars.showToastification(
                context,
                "Changed Experiences Dates successfully.",
                ToastificationType.success);
            Navigator.pop(context);
            context.read<WorkExperienceBloc>().add(
                WorkExperienceGetWorkExperience(fireAuth.currentUser!.uid));
          }
        },
        builder: (context, state) {
          if (state is WorkExperienceLoading) {
            return const LoadingWidget(caption: "");
          }
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  ///
                  WorkExperienceDates(
                    dateController: startDateController,
                    hintText:
                        changeDateFormat(widget.workExperience['start_date']),
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

                  //
                  stillWorking
                      ? const SizedBox()
                      : WorkExperienceDates(
                          dateController: stopDateController,
                          hintText: changeDateFormat(
                              widget.workExperience['stop_date']),
                        ),

                  SizedBox(height: size.height / 30),
                  ElevatedButtons(
                    buttonName: "Change",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log("validted");
                        changeWorkExperiencesDates();
                      } else {
                        log("Not validated");
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
