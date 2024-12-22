import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/navigation/routes/routs.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'di/dependency_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.initialize();
  final injector = DependencyInjector();
  injector.setup();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => injector.eventCategoryBloc),
      BlocProvider(create: (context) => injector.authBloc),
      BlocProvider(create: (context) => ThemeCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flare Up Admin',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: isDark ? Brightness.dark : Brightness.light,
            ),
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouts.generateRoute,
          initialRoute: AppRouts.logo,
        );
      },
    );
  }
}
