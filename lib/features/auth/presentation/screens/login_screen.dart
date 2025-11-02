import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/utils/ui_utiles.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widgets/custom_text_field.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit_states.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObscure = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      await BlocProvider.of<AuthCubit>(context).login(
        LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitStates>(
      listener: (context, state) {
        if (state is LoginLoadingSate) {
          UIUtiles.showLoading(context);
        } else if (state is LoginSucessState) {
          UIUtiles.hideLoading(context);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else if (state is LoginFailiarState) {
          UIUtiles.hideLoading(context);
          UIUtiles.showMessage(state.message);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/loginBackground.png',
                fit: BoxFit.cover,
              ),
            ),

            Container(color: Colors.black.withValues(alpha: 0.4)),

            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// 🛍️ Logo + Title
                      Column(
                        children: [
                          Text(
                            "ShopZone",
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Welcome Back To ShopZone!",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),

                      /// ✉️ Email Field
                      CustomTextField(
                        hintText: "Enter your email",
                        controller: emailController,
                        validator: Validators.validateEmail,
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 25.h),

                      /// 🔒 Password Field
                      CustomTextField(
                        hintText: "Enter your password",
                        controller: passwordController,
                        validator: Validators.validatePassword,
                        obscureText: isObscure,
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: AppTheme.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                      ),

                      /// 🔁 Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),

                      /// 🚀 Login Button
                      CustomElevatedButton(text: "Login", onPressed: login),
                      SizedBox(height: 25.h),

                      /// 🧾 Sign Up Redirect
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RegisterScreen.routeName,
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
