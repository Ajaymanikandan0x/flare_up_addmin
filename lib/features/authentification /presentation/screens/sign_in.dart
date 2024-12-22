import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/routes/routs.dart';
import '../../../../core/themes/text_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/form_field.dart';
import '../../../../core/widgets/logo_gradient.dart';
import '../../../../core/widgets/password_field.dart';
import '../../../../core/widgets/primary_button.dart';

import '../../../../di/dependency_injector.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import '../widgets/auth/sign_up_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final authBloc = DependencyInjector().authBloc;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding,
        vertical: Responsive.verticalPadding,
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthSuccess) {
            final role = state.userEntity.role;
            if (role == 'admin') {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRouts.adminHome, (_) => false);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Responsive.screenHeight * 0.15),
                LogoGradientText(fontSize: Responsive.titleFontSize * 2.5),
                SizedBox(height: Responsive.spacingHeight * 1.6),
                Align(
                  alignment: const Alignment(-1, 0.0),
                  child: Text(
                    'Sign in',
                    style: AppTextStyles.primaryTextTheme(
                      fontSize: Responsive.titleFontSize,
                    ),
                  ),
                ),
                SizedBox(height: Responsive.spacingHeight),
                AppFormField(
                  hint: 'name',
                  icon: const Icon(Icons.person),
                  controller: nameController,
                  validator: FormValidator.validateUserName,
                ),
                SizedBox(height: Responsive.spacingHeight),
                PasswordField(
                  hint: 'password',
                  icon: const Icon(Icons.lock),
                  controller: passwordController,
                  validator: FormValidator.validatePassword,
                ),
                SizedBox(height: Responsive.spacingHeight * 2),
                PrimaryButton(
                  width: Responsive.screenWidth * 0.85,
                  height: Responsive.buttonHeight,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (nameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please fill in all fields")),
                        );
                      } else {
                        authBloc.add(LoginEvent(
                            username: nameController.text,
                            password: passwordController.text));
                      }
                    }
                  },
                  fontSize: Responsive.titleFontSize,
                  text: 'Sign in',
                ),
                SizedBox(height: Responsive.spacingHeight),
                Text(
                  'or',
                  style: AppTextStyles.hindTextTheme(
                    fontSize: Responsive.subtitleFontSize,
                  ),
                ),
                SizedBox(height: Responsive.spacingHeight),
                AuthPromptText(
                  prefixText: 'Don\'t have an account?',
                  suffixText: 'Sign Up',
                  onTap: () {
                    Navigator.pushNamed(context, AppRouts.signUp);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
