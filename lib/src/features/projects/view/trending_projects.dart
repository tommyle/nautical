import 'package:flutter/material.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/models/projects.dart';
import 'package:nautical/src/shared/views/image_clipper.dart';
import 'package:nautical/src/shared/views/link_text.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/views/views.dart';

class TrendingProjects extends StatelessWidget {
  const TrendingProjects(
      {super.key, required this.projects, required this.constraints});

  final List<Project> projects;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTable<Project>(
      items: projects,
      breakpoint: 1024,
      columns: const [
        DataColumn(
          label: AdaptiveText('Rank'),
        ),
        DataColumn(
          label: AdaptiveText('Project name'),
        ),
        DataColumn(
          label: AdaptiveText('When'),
        ),
        DataColumn(
          label: AdaptiveText('Mint Link'),
        ),
        DataColumn(
          label: AdaptiveText('Description'),
        ),
      ],
      rowBuilder: (_, index) {
        final project = projects[index];

        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(
              AdaptiveText('${index + 1}'),
            ),
            DataCell(
              Clickable(
                onTap: () => context.go('/projects/${project.id}'),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                    child: ClippedImage(project.image),
                  ),
                  const SizedBox(width: 12),
                  Text(project.name),
                ]),
              ),
            ),
            DataCell(
              SizedBox(
                width: 80,
                child: AdaptiveText(project.formattedDate),
              ),
            ),
            const DataCell(
              SizedBox(
                width: 80,
                child: LinkText(
                  linkTitle: 'Mint',
                  linkAddress: 'https://www.fluttertemplates.com',
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 300,
                child: AdaptiveText(
                  project.description,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        );
      },
      itemBuilder: (project, index) {
        return ListTile(
          onTap: () => context.go('/projects/${project.id}'),
          leading: ClippedImage(project.image),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: AdaptiveText(
              project.name,
              style: context.titleMedium,
            ),
          ),
          subtitle: AdaptiveText(
            '${project.formattedDate} -  ${project.description}',
            style: context.labelMedium,
          ),
        );
      },
    );
  }
}
