import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/role_controller.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    // Carga rol desde SharedPreferences -> actualiza provider
    await ref.read(userRoleProvider.notifier).hydrateFromStorage();
    if (!mounted) return;

    // Decide ruta
    final role = ref.read(userRoleProvider);
    // Pequeña demora para mostrar el splash (opcional)
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;
    if (role == null) {
      context.go('/role');
    } else {
      context.go('/visits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
