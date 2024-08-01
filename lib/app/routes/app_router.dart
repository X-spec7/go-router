import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_auth/app/routes/route_utils.dart';
import 'package:gorouter_auth/app/routes/screens/not_found_page.dart';
import 'package:gorouter_auth/screens/home_screen.dart';
import 'package:gorouter_auth/screens/login_screen.dart';

class AppRouter {

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: PAGES.home.appPath,
          name: PAGES.home.appName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: PAGES.login.appPath,
          name: PAGES.login.appName,
          builder: (context, state) => const LoginScreen(),
        ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}
