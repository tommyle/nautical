import 'package:flutter/material.dart';
import '../../../shared/extensions.dart';
import '../../../shared/providers/projects.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          projectImage(constraints),
        ]),
      );
    });
  }

  Container projectImage(BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        left: 14,
        right: 24,
        bottom: 14,
      ),
      width: constraints.isMobile ? null : 250,
      child: Image.asset(item.image),
    );
  }
}
