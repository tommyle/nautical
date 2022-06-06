import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/models/projects.dart';
import 'package:nautical/src/shared/views/views.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final colors = Theme.of(context).colorScheme;

      return ListView(
        shrinkWrap: true,
        children: [
          constraints.isMobile
              ? compressedHeader(context, colors, constraints)
              : fullHeader(context, colors, constraints),
          const SizedBox(height: 12.0),
          const Divider(
            indent: 12,
            endIndent: 12,
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0,
            ),
            child: Text(
              'Collection',
              style: context.headlineSmall,
            ),
          ),
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
            itemCount: project.items.length,
            itemBuilder: (context, index) {
              final item = project.items[index];
              return GestureDetector(
                child: ImageTile(
                  image: item.image,
                  title: item.name,
                  subtitle: item.description,
                ),
                onTap: () =>
                    context.go('/projects/${project.id}/item/${item.id}'),
              );
            },
          ),
        ],
      );
    });
  }

  Row fullHeader(
    BuildContext context,
    ColorScheme colors,
    BoxConstraints constraints,
  ) {
    return Row(
      children: [
        projectImage(constraints, context),
        projectDescription(
          context,
          colors,
          constraints,
        ),
      ],
    );
  }

  Column compressedHeader(
    BuildContext context,
    ColorScheme colors,
    BoxConstraints constraints,
  ) {
    return Column(
      children: [
        projectImage(constraints, context),
        projectDescription(
          context,
          colors,
          constraints,
        ),
      ],
    );
  }

  Widget projectDescription(
    BuildContext context,
    ColorScheme colors,
    BoxConstraints constraints,
  ) {
    return Padding(
      padding: constraints.isMobile
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            project.name,
            style: context.displaySmall!.copyWith(color: colors.onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'By ${project.creator}',
            style: context.bodyLarge!.copyWith(),
          ),
          const SizedBox(height: 24),
          Text(
            project.description,
            style: context.bodyLarge!.copyWith(
              color: colors.onSurface.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: colors.tertiary,
                ),
                onPressed: () {},
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: colors.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container projectImage(BoxConstraints constraints, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        left: 14,
        right: 24,
        bottom: 14,
      ),
      width: constraints.isMobile ? MediaQuery.of(context).size.width : 250,
      child: Image.asset(
        project.image,
        fit: BoxFit.fill,
      ),
    );
  }
}
