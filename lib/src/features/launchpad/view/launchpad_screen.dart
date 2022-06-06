import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/providers/projects.dart';
import 'project_card.dart';

class LaunchpadScreen extends StatelessWidget {
  const LaunchpadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = ProjectsProvider();
    final projects = provider.projects;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        primary: false,
        appBar: AppBar(
          title: const Text('LAUNCHPAD'),
          toolbarHeight: kToolbarHeight * 2,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            sectionHeader(context, 'Live'),
            grid(constraints, projects.sublist(0, 3)),
            const SizedBox(height: 24,),
            sectionHeader(context, 'Upcoming'),
            grid(constraints, projects.sublist(3, 8)),
          ],
        ),
      );
    });
  }

  Padding sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: Text(
        title,
        style: context.headlineSmall,
      ),
    );
  }

  GridView grid(BoxConstraints constraints, List<Project> projects) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: max(1, (constraints.maxWidth ~/ 400).toInt()),
        childAspectRatio: 2.5,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return GestureDetector(
          child: ProjectCard(
            project: project,
          ),
          onTap: () => context.go('/projects/${project.id}'),
        );
      },
    );
  }
}
