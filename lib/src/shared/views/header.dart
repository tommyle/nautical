import 'package:flutter/material.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/views/views.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: AdaptiveText(
        title,
        style: context.headlineSmall,
      ),
    );
  }
}
