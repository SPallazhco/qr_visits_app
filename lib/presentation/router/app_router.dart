import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/role_selection_page.dart';
import '../features/visits/visits_list_page.dart';
import '../features/splash/splash_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SplashPage()),
      ),
      GoRoute(
        path: '/role',
        name: 'role',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RoleSelectionPage()),
      ),
      GoRoute(
        path: '/visits',
        name: 'visits',
        pageBuilder: (context, state) =>
            const MaterialPage(child: VisitsListPage()),
      ),
    ],
  );
});
