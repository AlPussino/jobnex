import 'package:flutter/material.dart';

class Oppotunities extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> jobRecruitmentData;
  const Oppotunities({
    super.key,
    required this.size,
    required this.jobRecruitmentData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
            title: Text(
          "About the Oppotunities",
          style: Theme.of(context).primaryTextTheme.bodySmall,
        )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            jobRecruitmentData['about_the_oppotunity'],
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
