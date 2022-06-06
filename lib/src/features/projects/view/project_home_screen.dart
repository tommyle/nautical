import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/models/projects.dart';
import 'package:nautical/src/shared/providers/projects_provider.dart';
import 'package:nautical/src/shared/views/header.dart';
import 'package:nautical/src/shared/views/views.dart';

class ProjectHomeScreen extends StatelessWidget {
  const ProjectHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectsProvider projectsProvider = ProjectsProvider();
    List<Project> projects = projectsProvider.projects;

    return LayoutBuilder(
      builder: (context, constraints) {
        return LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(title: 'All'),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
          );
        });
      },
    );
  }
}
