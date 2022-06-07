import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/features/projects/projects.dart';
import 'package:nautical/src/features/projects/view/item_screen.dart';
import 'package:nautical/src/shared/providers/projects_provider.dart';
import 'package:universal_platform/universal_platform.dart';

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

final _persistentNavigation =
    !(UniversalPlatform.isIOS || UniversalPlatform.isAndroid);

final appRouter = GoRouter(
  urlPathStrategy: UrlPathStrategy.hash,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          title: 'Home',
          key: _scaffoldKey,
          currentIndex: 0,
          isRoot: true,
          child: HomeScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/launchpad',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          title: 'Launchpad',
          key: _scaffoldKey,
          currentIndex: 1,
          isRoot: true,
          child: LaunchpadScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          title: 'Projects',
          key: _scaffoldKey,
          currentIndex: 2,
          isRoot: true,
          child: ProjectHomeScreen(),
        ),
      ),
      routes: [
        GoRoute(
          path: ':pid',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RootLayout(
              title: projectsProvider.getProject(state.params['pid']!).name,
              key: _scaffoldKey,
              currentIndex: 2,
              isRoot: _persistentNavigation,
              child: ProjectScreen(
                project: projectsProvider.getProject(state.params['pid']!),
              ),
            ),
          ),
          routes: [
            GoRoute(
              path: 'item/:id',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: RootLayout(
                  title: projectsProvider
                      .getItem(state.params['pid']!, state.params['id']!)
                      .name,
                  key: _scaffoldKey,
                  currentIndex: 2,
                  isRoot: _persistentNavigation,
                  child: ItemScreen(
                    project: projectsProvider.getProject(state.params['pid']!),
                    item: projectsProvider.getItem(
                        state.params['pid']!, state.params['id']!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
