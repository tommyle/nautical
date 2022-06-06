import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nautical/src/shared/extensions.dart';
import 'package:nautical/src/shared/views/views.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold(
      {super.key,
      required this.destinations,
      required this.selectedIndex,
      required this.onDestinationSelected,
      required this.child,
      required this.title,
      this.logo = const SizedBox()});

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;
  final Widget child;
  final Widget logo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Platform.isIOS || Platform.isAndroid) {
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              items: destinations
                  .map(
                    (d) => BottomNavigationBarItem(
                      icon: d.icon,
                      label: d.label,
                    ),
                  )
                  .toList(),
              currentIndex: selectedIndex,
              onTap: onDestinationSelected,
            ),
          );
        } else if (constraints.isMobile) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: child,
            drawer: Drawer(
              width: 230, //MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo,
                  Flexible(
                    child: NavigationRail(
                      extended: true,
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
                      onDestinationSelected: (int index) {
                        Navigator.pop(context);
                        onDestinationSelected(index);
                      },
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: BrightnessToggle(),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    logo,
                    Flexible(
                      child: NavigationRail(
                        extended: true,
                        minExtendedWidth: 220,
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
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: BrightnessToggle(),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: child,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
