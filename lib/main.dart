import 'package:e_commerce_app/core/app_bloc_observer.dart';
import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/dependency-injection/service_locator.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/core/main_screen.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:e_commerce_app/features/product-details/presentation/screens/product_details_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // call the configureDependencies which call the init function
  // to register all the dependencies inside the service locator
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => serviceLocator<AuthCubit>(),
        ),
        BlocProvider(create: (context) => serviceLocator<CartCubit>()),
      ],
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
                MainScreen.routeName: (context) => MainScreen(),
                ProductScreen.routeName: (context) => const ProductScreen(),
                ProductDetailsScreen.routeName:
                    (context) => const ProductDetailsScreen(),
                CartScreen.routeName: (context) => const CartScreen(),
              },

              initialRoute: HomeScreen.routeName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
            ),
      ),
    );
  }
}
