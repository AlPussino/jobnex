import 'package:flutter/material.dart';

class Oppotunities extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> JobRecruitmentData;
  const Oppotunities(
      {super.key, required this.size, required this.JobRecruitmentData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const ListTile(
          title: Text("About the Oppotunities"),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            JobRecruitmentData['about_the_oppotunity'],
          ),
        ),
      ],
    );
  }
}
