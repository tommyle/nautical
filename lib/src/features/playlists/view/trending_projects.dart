import 'package:flutter/material.dart';
import 'package:nautical/src/shared/views/link_text.dart';

import '../../../shared/providers/projects.dart';
import '../../../shared/views/image_clipper.dart';
import '../../../shared/views/views.dart';

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
          label: Text('Rank'),
        ),
        DataColumn(
          label: Text('Project name'),
        ),
        DataColumn(
          label: Text('When'),
        ),
        DataColumn(
          label: Text('Mint Link'),
        ),
        DataColumn(
          label: Text('Description'),
        ),
      ],
      rowBuilder: (context, index) {
        final project = projects[index];

        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(
              Text('${index + 1}'),
            ),
            DataCell(
              Row(children: [
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
            DataCell(
              SizedBox(
                width: 80,
                child: Text(project.formattedDate),
              ),
            ),
            DataCell(
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
                child: Text(
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
          onTap: () => {},
          leading: ClippedImage(project.image),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: LinkText(
              linkTitle: '${project.name}',
              linkAddress: 'https://www.fluttertemplates.com',
            ),
          ),
          subtitle: Text('${project.formattedDate} -  ${project.description}'),
        );
      },
    );
  }
}
