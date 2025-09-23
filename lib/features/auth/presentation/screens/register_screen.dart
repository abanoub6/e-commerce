import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
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
      //TODO: Implement Register Functionality

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Account Created ✅")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/routeLogo.png', height: 100),
                  const SizedBox(height: 20),
                  Text(
                    'Create Your Account',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Please fill the details below',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.start,
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

                  const SizedBox(height: 50),

                  // Register Button
                  CustomElevatedButton(text: "Sign Up", onPressed: register),

                  const SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // ⬅️ يرجع للـ Login
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
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
      ),
    );
  }
}
