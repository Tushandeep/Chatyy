import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/loading.dart';
import '/widgets/custom_dialog_box.dart';
import '/widgets/custom_text_input_field.dart';
import '/models/error.dart';
import '/controllers/auth.dart';
import '/animations/size_fade.dart';

part 'variables/variables.dart';
part 'components/profile_picker.dart';
part 'functions/picker_options_dialog.dart';
part 'functions/pick_image.dart';
part 'functions/authenticate.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 800),
    );

    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _authController = Get.find<AuthController>()
      ..authMode.listen(
        (value) {
          if (value == AuthMode.login && _animationController.isCompleted) {
            _animationController.reverse();
          } else if (value == AuthMode.signup) {
            _animationController.forward();
          }
        },
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User profile picker...
              FadeSizeTransition(
                controller: _animationController,
                child: const ProfilePickerWidget(),
              ),

              // Username Field...
              FadeSizeTransition(
                controller: _animationController,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                  child: CustomTextInputField(
                    controller: _nameController,
                    labelText: "Username",
                    prefixIcon: Icon(
                      Iconsax.edit,
                      color: _theme.iconTheme.color,
                    ),
                  ),
                ),
              ),
              // Email Field...
              CustomTextInputField(
                controller: _emailController,
                labelText: "Email",
                prefixIcon: Icon(
                  Iconsax.sms,
                  color: _theme.iconTheme.color,
                ),
              )
                  .animate(
                    autoPlay: true,
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  )
                  .slideY(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    begin: .5,
                    end: 0,
                  ),
              const SizedBox(height: 20),

              // Password Field...
              StatefulBuilder(
                builder: (context, update) {
                  return CustomTextInputField(
                    controller: _passwordController,
                    labelText: "Password",
                    obscureText: !_obscurePass,
                    prefixIcon: Icon(
                      Iconsax.lock,
                      color: _theme.iconTheme.color,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        update(() {
                          _obscurePass = !_obscurePass;
                        });
                      },
                      child: Icon(
                        (_obscurePass) ? Iconsax.eye_slash : Iconsax.eye,
                        color: _theme.iconTheme.color,
                      ),
                    ),
                  );
                },
              )
                  .animate(
                    autoPlay: true,
                    delay: const Duration(milliseconds: 200),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  )
                  .slideY(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    begin: .5,
                    end: 0,
                  ),

              // Confirm Password...
              FadeSizeTransition(
                controller: _animationController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: StatefulBuilder(
                    builder: (context, update) {
                      return CustomTextInputField(
                        controller: _confirmPasswordController,
                        labelText: "Confirm Password",
                        obscureText: !_obscureConfirmPass,
                        prefixIcon: Icon(
                          Iconsax.key,
                          color: _theme.iconTheme.color,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            update(() {
                              _obscureConfirmPass = !_obscureConfirmPass;
                            });
                          },
                          child: Icon(
                            (_obscureConfirmPass)
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                            color: _theme.iconTheme.color,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatefulBuilder(builder: (context, update) {
                      return GestureDetector(
                        onTap: () {
                          update(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: (_rememberMe)
                                    ? _theme.colorScheme.primary
                                    : null,
                                border: Border.all(
                                  color: _theme.colorScheme.primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: (_rememberMe)
                                  ? Icon(
                                      Icons.check_rounded,
                                      color: _theme.scaffoldBackgroundColor,
                                      size: 16,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "Remember Me",
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.1,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    Obx(
                      () => (_authController.authMode.value == AuthMode.signup)
                          ? const Center()
                          : const Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.1,
                              ),
                            ),
                    )
                  ],
                ),
              )
                  .animate(
                    autoPlay: true,
                    delay: const Duration(milliseconds: 400),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  )
                  .slideY(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    begin: .5,
                    end: 0,
                  ),

              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(
                  () => (_authController.isLoading.value)
                      ? const Loading()
                      : MaterialButton(
                          onPressed: () => _submitAuthForm(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: _theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          focusElevation: 0,
                          disabledElevation: 0,
                          highlightElevation: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                (_authController.authMode.value ==
                                        AuthMode.login)
                                    ? "Login"
                                    : "Signup",
                                style: _theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.4,
                                  color: _theme.scaffoldBackgroundColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Iconsax.arrow_right_1,
                                color: _theme.scaffoldBackgroundColor,
                              ),
                            ],
                          )
                              .animate(
                                autoPlay: true,
                                delay: const Duration(milliseconds: 650),
                              )
                              .fadeIn(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeInOut,
                              )
                              .slideX(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                                begin: -.5,
                                end: 0,
                              ),
                        ),
                ),
              )
                  .animate(
                    autoPlay: true,
                    delay: const Duration(milliseconds: 500),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  )
                  .slideY(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    begin: .5,
                    end: 0,
                  ),

              const SizedBox(height: 30),
              Obx(
                () => Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              (_authController.authMode.value == AuthMode.login)
                                  ? "Don't have an account? "
                                  : "Already have an account? ",
                          style: _theme.textTheme.bodySmall?.copyWith(
                            letterSpacing: 1.1,
                          ),
                        ),
                        TextSpan(
                          text:
                              (_authController.authMode.value == AuthMode.login)
                                  ? "Sign up"
                                  : "Login",
                          style: _theme.textTheme.bodyLarge?.copyWith(
                            letterSpacing: 1.1,
                            color: _theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _authController.toggleAuthMode();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .animate(
                    autoPlay: true,
                    delay: const Duration(milliseconds: 750),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  )
                  .slideY(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    begin: .5,
                    end: 0,
                  ),
              SizedBox(height: _mediaQuery.viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
