import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/models/projects.dart';
import 'package:nautical/src/shared/views/outlined_card.dart';
import 'package:nautical/src/shared/views/views.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({
    required this.project,
    required this.item,
    super.key,
  });

  final Project project;
  final Item item;

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
          properties(context, constraints),
          const Divider(
            indent: 12,
            endIndent: 12,
          ),
          const SizedBox(height: 12.0),
          collection(context, constraints),
        ],
      );
    });
  }

  Column properties(BuildContext context, BoxConstraints constraints) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 0,
          ),
          child: Text(
            'Properties',
            style: context.headlineSmall,
          ),
        ),
        SizedBox(
          width: 740,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: min((constraints.maxWidth ~/ 175).toInt(), 4),
              childAspectRatio: 1.8,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: item.properties.length,
            itemBuilder: (context, index) {
              final property = item.properties[index];

              return OutlinedCard(
                borderWidth: 0.1,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        property.type,
                        style: context.labelSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        property.name,
                        style: context.labelLarge?.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${property.percentage.roundToDouble()}% have this trait',
                        style: context.labelMedium?.copyWith(
                          color: colors.tertiary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column collection(BuildContext context, BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 0,
          ),
          child: Text(
            'More from this collection',
            style: context.headlineSmall,
          ),
        ),
        SizedBox(
          width: 1024,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: min((constraints.maxWidth ~/ 175).toInt(), 6),
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
        ),
      ],
    );
  }

  Row fullHeader(
    BuildContext context,
    ColorScheme colors,
    BoxConstraints constraints,
  ) {
    return Row(
      children: [
        projectImage(context, constraints),
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
        projectImage(context, constraints),
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
            item.name,
            style: context.headlineLarge!.copyWith(color: colors.onSurface),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Text(
            'By ${project.creator}',
            style: context.bodyLarge!.copyWith(),
          ),
          const SizedBox(height: 24),
          Text(
            item.description,
            style: context.bodyLarge!.copyWith(
              color: colors.onSurface.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          buttonsToolbar(colors),
          const SizedBox(height: 16),
          Container(
            height: 130,
            width: 400,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.secondaryContainer.withOpacity(0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Price',
                  style: context.labelMedium!.copyWith(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.diamond),
                    const SizedBox(width: 8),
                    Text(
                      '${item.price.roundToDouble()} ETH',
                      style: context.headlineSmall!.copyWith(),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      "Make offer",
                      style: TextStyle(
                        fontSize: 16,
                        color: colors.tertiary,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row buttonsToolbar(ColorScheme colors) {
    return Row(
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
    );
  }

  Container projectImage(BuildContext context, BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        left: 14,
        right: 24,
        bottom: 14,
      ),
      width: constraints.isMobile ? MediaQuery.of(context).size.width : 400,
      child: Image.asset(
        item.image,
        fit: BoxFit.fill,
      ),
    );
  }
}
