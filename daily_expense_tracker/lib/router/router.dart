import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../AuthenicationScreen/login.dart';
import '../AuthenicationScreen/signup.dart';
import '../AuthenicationScreen/forgot_password.dart';
import '../pages/navigation_lightweight.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      },
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUp();
      },
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPassword();
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const MainNavigation();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found',
        style: const TextStyle(fontSize: 18),
      ),
    ),
  ),
);
