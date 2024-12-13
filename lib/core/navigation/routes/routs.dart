import 'package:flare_up_admin/features/dashboard/presentation/pages/signin_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/dashboard/presentation/pages/home.dart';
import '../../../features/dashboard/presentation/pages/logo.dart';

class AppRouts {
  static const logo = '/';
  static const signIn = '/signIn';
  static const hostHome = '/home';
  static const signUp = '/signUp';
  static const hostProfile = '/profile';
  static const otpScreen = '/otpScreen';
  static const editProf = '/editProfile';
  static const forgotPassword = '/forgotPassword';
  static const resetPassword = '/resetPassword';
  static const chat = '/chat';
  static const location = '/location';
  static const appNav = '/app_nav';

  static final Map<String, Widget Function(BuildContext)> routs = {
    logo: (context) => const Logo(),
    signIn: (context) =>  SigninScreen(),
    hostHome: (context) => const AdminHomePage(),
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
