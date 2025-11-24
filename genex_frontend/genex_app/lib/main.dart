// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/auth/signup_view.dart';
import 'views/auth/signin_view.dart';
import 'views/home_view.dart';
import 'viewmodels/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize providers if needed by reading them:
    ref.read(apiServiceProvider);
    ref.read(authRepositoryProvider);

    return MaterialApp(
      title: 'Autoimmune App',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/': (ctx) => const SigninView(),
        '/signin': (ctx) => const SigninView(),
        '/signup': (ctx) => const SignupView(),
        '/home': (ctx) => const HomeView(),
      },
      initialRoute: '/',
    );
  }
}
