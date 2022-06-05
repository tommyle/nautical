import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/features/playlists/projects.dart';
import 'package:nautical/src/features/playlists/view/item_screen.dart';
import 'package:nautical/src/shared/providers/providers.dart';

import '../features/home/home.dart';
import '../features/launchpad/view/launchpad_screen.dart';
import 'views/views.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

final projectsProvider = ProjectsProvider();

const List<NavigationDestination> destinations = [
  NavigationDestination(
    label: 'Home',
    icon: Icon(Icons.store),
    route: '/',
  ),
  NavigationDestination(
    label: 'Launchpad',
    icon: Icon(Icons.rocket_launch),
    route: '/launchpad',
  ),
  NavigationDestination(
    label: 'Projects',
    icon: Icon(Icons.diamond),
    route: '/projects',
  ),
];

class NavigationDestination {
  const NavigationDestination({
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

final appRouter = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 0,
          child: HomeScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/launchpad',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 1,
          child: LaunchpadScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 2,
          child: ProjectHomeScreen(),
        ),
      ),
      routes: [
        GoRoute(
            path: ':pid',
            pageBuilder: (context, state) => MaterialPage<void>(
                  key: state.pageKey,
                  child: RootLayout(
                    key: _scaffoldKey,
                    currentIndex: 2,
                    child: ProjectScreen(
                      project:
                          projectsProvider.getProject(state.params['pid']!),
                    ),
                  ),
                ),
            routes: [
              GoRoute(
                path: 'item/:id',
                pageBuilder: (context, state) => MaterialPage<void>(
                  key: state.pageKey,
                  child: RootLayout(
                    key: _scaffoldKey,
                    currentIndex: 2,
                    child: ItemScreen(
                      project:
                          projectsProvider.getProject(state.params['pid']!),
                      item: projectsProvider.getItem(
                          state.params['pid']!, state.params['id']!),
                    ),
                  ),
                ),
              ),
            ]),
      ],
    ),
  ],
);
