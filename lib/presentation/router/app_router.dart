import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_visits_app/presentation/features/scan/scan_page.dart';
import 'package:qr_visits_app/presentation/features/visit_create/create_visit_page.dart';
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
      GoRoute(
        path: '/visits/new',
        name: 'visit_create',
        pageBuilder: (context, state) =>
            const MaterialPage(child: CreateVisitPage()),
      ),
      GoRoute(
        path: '/scan',
        name: 'scan',
        pageBuilder: (context, state) => const MaterialPage(child: ScanPage()),
      ),
    ],
  );
});
