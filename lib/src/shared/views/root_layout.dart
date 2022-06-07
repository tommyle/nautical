import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as go;
import 'package:nautical/src/shared/views/logo.dart';

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
          return AdaptiveScaffold(
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
                  child: _Switcher(
                    key: _switcherKey,
                    child: child,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: SafeArea(
              child: _Switcher(
                key: _switcherKey,
                child: child,
              ),
            ),
          );
        }
      },
    );
  }
}

class _Switcher extends StatelessWidget {
  final bool isDesktop = defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows;
  final Widget child;

  _Switcher({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? child
        : AnimatedSwitcher(
            key: key,
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: child,
          );
  }
}
