import 'package:e_commerce_app/core/app_bloc_observer.dart';
import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/dependency-injection/service_locator.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  setup();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),

      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder:
            (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                LoginScreen.routeName: (context) => LoginScreen(),
                RegisterScreen.routeName: (context) => const RegisterScreen(),
                HomeScreen.routeName: (context) => const HomeScreen(),
              },

              initialRoute: LoginScreen.routeName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
            ),
      ),
    );
  }
}
