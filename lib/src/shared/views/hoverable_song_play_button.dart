import 'package:flutter/material.dart';
import '../classes/classes.dart';
import '../views/views.dart';

/// Renders the child widget when not hovered and a Play button when hovered.
class HoverableSongPlayButton extends StatelessWidget {
  const HoverableSongPlayButton({
    super.key,
    required this.song,
    required this.child,
    this.size = const Size(50, 50),
    this.hoverMode = HoverMode.replace,
  });

  final Widget child;
  final Size size;
  final Song song;
  final HoverMode hoverMode;

  @override
  Widget build(BuildContext context) {
    return HoverToggle(
      hoverChild: Center(
        child: GestureDetector(child: const Icon(Icons.favorite), onTap: () {}),
      ),
      mode: hoverMode,
      size: size,
      child: child,
    );
  }
}
