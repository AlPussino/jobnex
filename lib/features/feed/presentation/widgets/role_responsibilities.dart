import 'package:flutter/material.dart';

class RoleResponsiblities extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> JobRecruitmentData;
  const RoleResponsiblities(
      {super.key, required this.size, required this.JobRecruitmentData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          title: Text("Role Responsiblities"),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            JobRecruitmentData['role_responsibility'],
          ),
        ),
      ],
    );
  }
}
