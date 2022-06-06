import 'package:flutter/material.dart';
import 'package:nautical/src/shared/extensions.dart';

class AdaptiveScaffold extends StatelessWidget {
  final BoxConstraints constraints;
  final Widget body;
  final String title;

  const AdaptiveScaffold({
    super.key,
    required this.constraints,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (constraints.isMobile) {
      return Scaffold(
        primary: false,
        appBar: AppBar(
          title: Text(title),
        ),
        body: body,
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: body,
          ),
        ),
      );
    }
  }
}
