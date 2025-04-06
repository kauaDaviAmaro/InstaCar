import 'package:go_router/go_router.dart';
import 'package:instacar/presentation/pages/password_reset.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/carona_details_page.dart';
import '../presentation/pages/forgot_password_page.dart';
import '../presentation/pages/code_page.dart';
import '../presentation/pages/password_reset.dart';
import '../presentation/pages/set_password.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation: isLoggedIn ? '/home' : '/login',
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
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
      path: '/set',
      builder: (context, state) => SetPassword(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
      // builder: (context, state) {
      //   return isLoggedIn ? HomePage() : LoginPage(); // Redirecionamento
      // },
    ),
    // GoRoute(
    //   path: '/carona/:id', // Rota dinâmica
    //   builder: (context, state) {
    //     final String caronaId = state.pathParameters['id']!;
    //     return CaronaDetailsPage(caronaId: caronaId);
    //   },
    // ),
  ],
);
