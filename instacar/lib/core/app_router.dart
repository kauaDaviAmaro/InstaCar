import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/carona_details_page.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation: isLoggedIn ? '/home' : '/login',
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
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
