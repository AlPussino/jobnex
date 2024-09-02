import 'package:flutter/material.dart';

class RoleResponsiblities extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> JobRecruitmentData;
  const RoleResponsiblities({
    super.key,
    required this.size,
    required this.JobRecruitmentData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(
            "Role Responsiblities",
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            JobRecruitmentData['role_responsibility'],
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
