import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../pickers/user_image_picker.dart';

enum AuthMode {
  signUp,
  logIn,
}

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext context,
  ) submitAuth;
  const AuthForm({
    Key? key,
    required this.submitAuth,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  AuthMode _authMode = AuthMode.logIn;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPassController;
  late TextEditingController _usernameController;
  File? _userImageFile;

  OutlineInputBorder get decorateBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.5,
      ),
    );
  }

  OutlineInputBorder get decorateErrorBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 2,
      ),
    );
  }

  InputDecoration _decorateTextField(String title, IconData prefixIcon) {
    return InputDecoration(
      labelText: title,
      hintText: title,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      errorStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      prefixIcon: Icon(prefixIcon, color: Theme.of(context).iconTheme.color),
      enabledBorder: decorateBorder,
      focusedBorder: decorateBorder,
      errorBorder: decorateErrorBorder,
      focusedErrorBorder: decorateErrorBorder,
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.signUp) {
      _usernameController.clear();
      _confirmPassController.clear();
      _userImageFile = File('');
      setState(() {
        _authMode = AuthMode.logIn;
      });
    } else {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    }
  }

  _showWarningDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _pickedImage(File? image) {
    _userImageFile = image;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_authMode == AuthMode.signUp) {
      if (_confirmPassController.text != _passwordController.text) {
        _confirmPassController.clear();
        _showWarningDialog('Error', 'Confirm Password Mismatch');
      } else if (_formKey.currentState!.validate()) {
        widget.submitAuth(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _usernameController.text.trim(),
          _userImageFile,
          (_authMode == AuthMode.logIn),
          context,
        );
      }
    } else if (_authMode == AuthMode.logIn) {
      if (_formKey.currentState!.validate()) {
        widget.submitAuth(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          '',
          File(''),
          (_authMode == AuthMode.logIn),
          context,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: (_authMode == AuthMode.signUp)
                    ? size.height * 0.1
                    : size.height * 0.3,
              ),
              if (_authMode == AuthMode.signUp) ...[
                UserImagePicker(
                  imagePickerFn: _pickedImage,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  enableSuggestions: false,
                  autocorrect: true,
                  validator: (val) {
                    if (_authMode == AuthMode.signUp) {
                      if (val!.isEmpty) {
                        return 'Empty Username Not Valid';
                      }
                      if (val.length <= 3) {
                        return 'Username must be atleast 4 characters long';
                      }
                      if (val.length >= 20) {
                        return 'Username length exceeded';
                      }
                    }
                    return null;
                  },
                  controller: _usernameController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  decoration: _decorateTextField('Username', Iconsax.user),
                ),
              ],
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                autocorrect: false,
                controller: _emailController,
                key: const ValueKey('email'),
                validator: (val) {
                  if (val!.isEmpty || !val.contains('@')) {
                    return 'Please valid email address';
                  }
                  return null;
                },
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                keyboardType: TextInputType.emailAddress,
                decoration: _decorateTextField(
                  'Email',
                  CupertinoIcons.mail,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _passwordController,
                key: const ValueKey('password'),
                validator: (val) {
                  if (val!.isEmpty || val.length < 7) {
                    return 'Password must be atleast of 8 characters';
                  }
                  return null;
                },
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: _decorateTextField('Password', Iconsax.key),
              ),
              if (_authMode == AuthMode.signUp) ...[
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _confirmPassController,
                  key: const ValueKey('confirmPassword'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: _decorateTextField(
                    'Confirm Password',
                    Iconsax.lock,
                  ),
                ),
              ],
              const SizedBox(height: 25),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                onPressed: _submit,
                minWidth: 100,
                height: 40,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                elevation: 0.0,
                textColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  (_authMode == AuthMode.logIn) ? 'Login' : 'Sign up',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'FiraCode',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  children: [
                    TextSpan(
                      text: (_authMode == AuthMode.signUp)
                          ? 'Already have an account?  '
                          : 'Don\'t have an account?  ',
                    ),
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _switchAuthMode();
                        },
                      text:
                          (_authMode == AuthMode.signUp) ? 'Log In' : 'Sign Up',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
