import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/utils/ui_utiles.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widgets/custom_text_field.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit_states.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObscure = true;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).register(
        RegisterRequest(
          name: fullNameController.text,
          phone: phoneController.text,
          email: emailController.text,
          password: passwordController.text,
          rePassword: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitStates>(
      listener: (context, state) {
        if (state is RegisterLoadingSate) {
          UIUtiles.showLoading(context);
        } else if (state is RegisterSucessState) {
          UIUtiles.hideLoading(context);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else if (state is RegisterFailiarState) {
          UIUtiles.hideLoading(context);
          UIUtiles.showMessage(state.message);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            /// 🖼 الخلفية
            Image.asset('assets/images/loginBackground.png', fit: BoxFit.cover),

            /// 🌫 طبقة شفافة فوق الخلفية
            Container(color: Colors.black.withValues(alpha: 0.4)),

            /// 📋 المحتوى
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 🛍 شعار التطبيق
                      Text(
                        'ShopZone',
                        style: TextStyle(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Create Your Account',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      // Full Name
                      CustomTextField(
                        hintText: "Enter your full name",
                        controller: fullNameController,
                        validator: Validators.validateFullName,
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 20),

                      // Phone Number
                      CustomTextField(
                        hintText: "Enter your phone number",
                        controller: phoneController,
                        validator: Validators.validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(height: 20),

                      // Email
                      CustomTextField(
                        hintText: "Enter your email",
                        controller: emailController,
                        validator: Validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 20),

                      // Password
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
                      const SizedBox(height: 40),

                      // Register Button
                      CustomElevatedButton(
                        text: "Sign Up",
                        onPressed: register,
                      ),
                      const SizedBox(height: 20),

                      // 🔙 الرجوع للـ Login
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                    color: Colors.greenAccent.shade400,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
