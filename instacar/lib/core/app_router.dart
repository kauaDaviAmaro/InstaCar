import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:instacar/presentation/pages/auth/register_page.dart';
import 'package:instacar/presentation/pages/chat/chat_list_page.dart';
import 'package:instacar/presentation/pages/main/caronas_page.dart';
import 'package:instacar/presentation/pages/main/favorites_page.dart';
import 'package:instacar/presentation/pages/auth/password_reset.dart';
import '../presentation/pages/main/contact_page.dart';
import '../presentation/pages/main/home_page.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/auth/forgot_password_page.dart';
import '../presentation/pages/auth/code_page.dart';
import '../presentation/pages/auth/set_password.dart';
import '../presentation/pages/main/profile_page.dart';
import '../core/services/user_service.dart';

import '../presentation/pages/main/edit_profile_page.dart';
import '../presentation/pages/main/terms_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: FavoritesPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/forgot',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: ForgotPasswordPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/code',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: CodePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/reset',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: PasswordReset(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: ProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/set',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: SetPassword(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/chat',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: FutureBuilder<String?>(
          future: UserService.getCurrentUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return ChatListPage(userId: snapshot.data ?? "unknown");
          },
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: "/register",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: RegisterPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/edit-profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const UserProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/terms',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: TermosDeServicoPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: FeedbackPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/caronas',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: CaronasPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
  ],
);
