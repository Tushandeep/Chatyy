part of '../auth_screen.dart';

void _submitAuthForm(BuildContext context) async {
  final Widget okButton = Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        foregroundColor:
            MaterialStatePropertyAll(_theme.scaffoldBackgroundColor),
        backgroundColor: MaterialStateProperty.all(_theme.colorScheme.primary),
      ),
      child: const Text("OK"),
    ),
  );

  if (_authController.authMode.value == AuthMode.signup &&
      _nameController.text.isEmpty) {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        type: DialogType.error,
        error: CustomError(
          title: "Error",
          message: "Invalid Username",
          solutions: [],
        ),
        actions: [
          okButton,
        ],
      ),
    );
  } else if (_authController.authMode.value == AuthMode.signup &&
      _nameController.text.length < 5) {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        type: DialogType.error,
        error: CustomError(
          title: "Error",
          message: "Username must be atleast 5 characters long",
          solutions: [],
        ),
        actions: [
          okButton,
        ],
      ),
    );
  } else if (_emailController.text.isEmpty ||
      _passwordController.text.isEmpty) {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        type: DialogType.error,
        error: CustomError(
          title: "Error",
          message: "Incorrect Email or Password",
          solutions: [],
        ),
        actions: [
          okButton,
        ],
      ),
    );
  } else if (_passwordController.text.length < 8) {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        type: DialogType.error,
        error: CustomError(
          title: "Error",
          message: "Password must be at least 8 characters long",
          solutions: [],
        ),
        actions: [
          okButton,
        ],
      ),
    );
  } else if (_authController.authMode.value == AuthMode.signup &&
      _passwordController.text != _confirmPasswordController.text) {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        type: DialogType.error,
        error: CustomError(
          title: "Error",
          message: "Password does not match",
          solutions: [],
        ),
        actions: [
          okButton,
        ],
      ),
    );
  } else if (_authController.authMode.value == AuthMode.login) {
    await _authController.login(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _rememberMe,
    );
  } else {
    await _authController.signup(
      context,
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _photo.value?.readAsBytesSync(),
      _rememberMe,
    );
  }
}
