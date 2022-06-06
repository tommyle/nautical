import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:nautical/src/features/projects/view/trending_projects.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/models/projects.dart';
import 'package:nautical/src/shared/router.dart';

import 'view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Project> projects = projectsProvider.projects;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: AdaptiveColumn(
          margin: 0,
          children: [
            AdaptiveContainer(
              columnSpan: 12,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Featured',
                        style: context.headlineLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: Column(
                children: const [
                  HomeHighlight(),
                ],
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Text(
                      'Recent Drops',
                      style: context.headlineSmall,
                    ),
                  ),
                  HomeRecent(projects: projects.sublist(0, 4)),
                ],
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Trending',
                              style: context.titleLarge,
                            ),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) => TrendingProjects(
                              projects: projects,
                              constraints: constraints,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
