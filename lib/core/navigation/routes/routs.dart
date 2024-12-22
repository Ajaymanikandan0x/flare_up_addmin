import 'package:flutter/material.dart';

import '../../../features/authentification /presentation/screens/logo.dart';
import '../../../features/authentification /presentation/screens/sign_in.dart';
import '../../../features/authentification /presentation/screens/sign_up.dart';
import '../../../features/dashboard/presentation/pages/home.dart';
import '../../../features/events/presentation/pages/event_category.dart';

class AppRouts {
  static const logo = '/';
  static const signIn = '/signIn';
  static const adminHome = '/home';
  static const signUp = '/signUp';
  static const adminProfile = '/profile';
  static const editProf = '/editProfile';

  static const eventCategory = '/event_category';
  static final Map<String, Widget Function(BuildContext)> routs = {
    logo: (context) => const Logo(),
    signIn: (context) => SignInScreen(),
    signUp: (_) => SignUpScreen(),
    adminHome: (context) => const AdminHomePage(),
    eventCategory: (context) => const EventCategoryPage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final builder = routs[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    }
    throw Exception('Route not found: ${settings.name}');
  }
}
