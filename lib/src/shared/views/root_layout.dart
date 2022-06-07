import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as go;
import 'package:nautical/src/shared/views/logo.dart';
import 'package:nautical/src/shared/views/switcher.dart';

import 'adaptive_scaffold.dart';

class NavItem {
  const NavItem({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

const List<NavItem> destinations = [
  NavItem(
    label: 'Home',
    icon: Icon(Icons.store),
    route: '/',
  ),
  NavItem(
    label: 'Launchpad',
    icon: Icon(Icons.rocket_launch),
    route: '/launchpad',
  ),
  NavItem(
    label: 'Projects',
    icon: Icon(Icons.diamond),
    route: '/projects',
  ),
];

class RootLayout extends StatelessWidget {
  const RootLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.title,
    required this.isRoot,
  });

  final Widget child;
  final int currentIndex;
  final String title;
  final bool isRoot;
  static const _switcherKey = ValueKey('switcherKey');
  static const _navigationRailKey = ValueKey('navigationRailKey');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        void onSelected(int index) {
          final destination = destinations[index];
          context.go(destination.route);
        }

        if (isRoot) {
          return WillPopScope(
            onWillPop: () async => !kIsWeb,
            child: AdaptiveScaffold(
              title: title,
              key: _navigationRailKey,
              destinations: destinations
                  .map((e) => NavigationDestination(
                        icon: e.icon,
                        label: e.label,
                      ))
                  .toList(),
              selectedIndex: currentIndex,
              onDestinationSelected: onSelected,
              logo: const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Logo(),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Switcher(
                      key: _switcherKey,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return WillPopScope(
            onWillPop: () async => !kIsWeb,
            child: Scaffold(
              appBar: AppBar(title: SelectionArea(child: Text(title))),
              body: SafeArea(
                child: Switcher(
                  key: _switcherKey,
                  child: child,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
