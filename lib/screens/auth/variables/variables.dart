part of '../auth_screen.dart';

late MediaQueryData _mediaQuery;
late ThemeData _theme;

late TextEditingController _emailController;
late TextEditingController _nameController;
late TextEditingController _passwordController;
late TextEditingController _confirmPasswordController;

// Profile Image...
late ValueNotifier<File?> _photo;

// For Password and Confirm Password....
bool _obscurePass = false;
bool _obscureConfirmPass = false;

// Remember Me
bool _rememberMe = false;

// AnimationController...
late AnimationController _animationController;

// GetX Controller...
late AuthController _authController;
