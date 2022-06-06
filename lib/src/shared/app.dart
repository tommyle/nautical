import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'providers/theme.dart';
import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = ValueNotifier(ThemeSettings(
    sourceColor: Colors.blue.shade700,
    themeMode: ThemeMode.system,
  ));
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => ThemeProvider(
        lightDynamic: lightDynamic,
        darkDynamic: darkDynamic,
        settings: settings,
        child: NotificationListener<ThemeSettingChange>(
          onNotification: (notification) {
            settings.value = notification.settings;
            return true;
          },
          child: ValueListenableBuilder<ThemeSettings>(
            valueListenable: settings,
            builder: (context, value, _) {
              final theme = ThemeProvider.of(context);
              return MaterialApp.router(
                scrollBehavior: AppScrollBehavior(),
                debugShowCheckedModeBanner: false,
                title: 'Nautical',
                theme: theme.light(settings.value.sourceColor),
                darkTheme: theme.dark(settings.value.sourceColor),
                themeMode: theme.themeMode(),
                routeInformationParser: appRouter.routeInformationParser,
                routerDelegate: appRouter.routerDelegate,
              );
            },
          ),
        ),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
      };
}
