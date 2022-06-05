import 'package:flutter/material.dart';
import 'package:nautical/src/shared/extensions.dart';

class AdaptiveNavigation extends StatelessWidget {
  const AdaptiveNavigation(
      {super.key,
      required this.destinations,
      required this.selectedIndex,
      required this.onDestinationSelected,
      required this.child,
      this.logo = const SizedBox()});

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;
  final Widget child;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Tablet Layout
        if (constraints.isDesktop) {
          return Scaffold(
            body: Row(
              children: [
                Column(
                  children: [
                    logo,
                    Flexible(
                      child: NavigationRail(
                        extended: true,
                        minExtendedWidth: 180,
                        destinations: destinations
                            .map((e) => NavigationRailDestination(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  icon: e.icon,
                                  label: Text(e.label),
                                ))
                            .toList(),
                        selectedIndex: selectedIndex,
                        onDestinationSelected: onDestinationSelected,
                      ),
                    ),
                  ],
                ),
                Expanded(child: child),
              ],
            ),
          );
        }
        // Mobile Layout
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            destinations: destinations,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
          ),
        );
      },
    );
  }
}
