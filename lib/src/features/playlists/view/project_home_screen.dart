import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/views/adaptive_scaffold.dart';
import 'package:nautical/src/shared/views/header.dart';

import '../../../shared/providers/providers.dart';
import '../../../shared/views/views.dart';

class ProjectHomeScreen extends StatelessWidget {
  const ProjectHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectsProvider projectsProvider = ProjectsProvider();
    List<Project> projects = projectsProvider.projects;

    return LayoutBuilder(
      builder: (context, constraints) {
        return LayoutBuilder(builder: (context, constraints) {
          return AdaptiveScaffold(
            title: 'Projects',
            constraints: constraints,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(title: 'All'),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (constraints.maxWidth ~/ 175).toInt(),
                      childAspectRatio: 0.70,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return GestureDetector(
                        child: ImageTile(
                          image: project.image,
                          title: project.name,
                          subtitle: project.description,
                        ),
                        onTap: () => context.go('/projects/${project.id}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
