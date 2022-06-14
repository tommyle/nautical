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
          pageBuilder: (context, state) {
            final project = projectsProvider.getProject(state.params['pid']!);

            return MaterialPage<void>(
              key: state.pageKey,
              child: RootLayout(
                title: project.name,
                key: _scaffoldKey,
                currentIndex: 2,
                isRoot: _persistentNavigation,
                child: ProjectScreen(
                  project: project,
                ),
              ),
            );
          },
          routes: [
            GoRoute(
              path: 'item/:id',
              pageBuilder: (context, state) {
                final project =
                    projectsProvider.getProject(state.params['pid']!);
                final item = projectsProvider.getItem(
                    state.params['pid']!, state.params['id']!);

                return MaterialPage<void>(
                  key: state.pageKey,
                  child: RootLayout(
                    title: item.name,
                    key: _scaffoldKey,
                    currentIndex: 2,
                    isRoot: _persistentNavigation,
                    child: ItemScreen(
                      project: project,
                      item: item,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
