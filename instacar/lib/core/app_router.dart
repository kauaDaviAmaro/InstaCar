import 'package:go_router/go_router.dart';
import 'package:instacar/presentation/pages/auth/register_page.dart';
import 'package:instacar/presentation/pages/chat/chat_list_page.dart';
import 'package:instacar/presentation/pages/main/favorites_page.dart';
import 'package:instacar/presentation/pages/auth/password_reset.dart';
import '../presentation/pages/main/home_page.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/auth/forgot_password_page.dart';
import '../presentation/pages/auth/code_page.dart';
import '../presentation/pages/auth/set_password.dart';
import '../presentation/pages/main/profile_page.dart';

import '../presentation/pages/main/edit_profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => FavoritesPage(),
    ),
    GoRoute(
      path: '/forgot',
      builder: (context, state) => ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/code',
      builder: (context, state) => CodePage(),
    ),
    GoRoute(
      path: '/reset',
      builder: (context, state) => PasswordReset(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/set',
      builder: (context, state) => SetPassword(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => ChatListPage(userId: "1"),
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),

    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const UserProfilePage(),
    ),
  ],
);
