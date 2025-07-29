import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:nks_traders/components/bottomappbar.dart';
import 'package:nks_traders/pages/CategoryPage.dart';

import 'package:nks_traders/pages/Login_page.dart' show LoginPage;
import 'package:nks_traders/pages/Otp_verification.dart';
import 'package:nks_traders/pages/allcat.dart';
import 'package:nks_traders/pages/cartpage.dart';
import 'package:nks_traders/pages/favourite.dart';
import 'package:nks_traders/pages/forgot_pass.dart';
import 'package:nks_traders/pages/homepage.dart';
import 'package:nks_traders/pages/logins_splash.dart';
import 'package:nks_traders/pages/profile.dart';
import 'package:nks_traders/pages/searchpage.dart';
import 'package:nks_traders/pages/signuppage.dart';
import 'package:nks_traders/pages/splashscreen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/LoginSplash',
      builder: (context, state) => const LoginSplash(),
    ),
    GoRoute(path: '/Login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/forgotpassword',
      builder: (context, state) => const ForgetPasswordPage(),
    ),
    GoRoute(path: '/Signup', builder: (context, state) => SignUpScreen()),
    GoRoute(
      path: '/Search',
      builder: (context, state) => ProductSearchScreen(),
    ),
    GoRoute(path: '/Otp', builder: (context, state) => OTPVerificationPage()),
    GoRoute(path: '/allProducts', builder: (context, state) => Allcat()),
    GoRoute(
      path: '/category/:label',
      builder: (context, state) {
        final label = state.pathParameters['label']!;
        return CategoryPage(category: label);
      },
    ),

    /// ✅ BOTTOM NAVIGATION ROUTES INSIDE SHELL
    ShellRoute(
      builder: (context, state, child) => BottomNavShell(child: child),
      routes: [
        GoRoute(
          path: '/Homepage',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/Favorites',
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(path: '/Cart', builder: (context, state) => CartScreen()),
        GoRoute(path: '/Profile', builder: (context, state) => ProfilePage()),
      ],
    ),
  ],
);
