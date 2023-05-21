import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '/models/user.dart';
import '/models/error.dart';
import '/repositories/auth.dart';
import '/widgets/custom_dialog_box.dart';

enum AuthMode {
  login,
  signup,
}

class AuthController extends GetxController {
  // Loading...
  final RxBool isLoading = false.obs;

  // To check the AuthMode is Login Form or Signup Form...
  final Rx<AuthMode> authMode = Rx<AuthMode>(AuthMode.login);

  // Create a new Empty User...
  final Rx<UserModel> user = Rx<UserModel>(UserModel.empty);

  void toggleAuthMode() {
    authMode(
      (authMode.value == AuthMode.login) ? AuthMode.signup : AuthMode.login,
    );
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password, [
    bool rememberMe = false,
  ]) async {
    try {
      isLoading(true);
      final UserModel user = await AuthRepository.login(email, password);

      // Save the user credentials in the Internal Database of Mobile
      // if the user select rememberMe...

      // Save the user credentials in the Memory of App for internal reference...
      // In the GetxController => AuthController.user...
      this.user(user);
      isLoading(false);
    } on FirebaseAuthException catch (err) {
      isLoading(false);
      final CustomError errorModel = CustomError(
        title: "Login Error",
        message: err.message ?? "Something went wrong",
      );

      showDialog(
        context: context,
        builder: (_) => DialogBox(
          error: errorModel,
          type: DialogType.error,
          actions: [
            Padding(
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
                ),
                child: const Text("OK"),
              ),
            ),
          ],
        )
            .animate(
              autoPlay: true,
            )
            .fadeIn(
              duration: const Duration(milliseconds: 150),
              begin: 0,
            )
            .scaleXY(
              begin: 3,
              end: 1,
              duration: const Duration(milliseconds: 150),
            ),
      );
    }
  }

  Future<void> signup(
    BuildContext context,
    String username,
    String email,
    String password,
    Uint8List? photo, [
    bool rememberMe = false,
  ]) async {
    try {
      isLoading(true);
      final UserModel user = await AuthRepository.signup(
        username,
        email,
        password,
        photo,
      );

      // Save the user credentials in the Internal Database of Mobile
      // if the user select rememberMe...

      // Save the user credentials in the Memory of App for internal reference...
      // In the GetxController => AuthController.user...
      this.user(user);
    } on FirebaseAuthException catch (err) {
      isLoading(false);
      final CustomError errorModel = CustomError(
        title: "Signup Error",
        message: err.message ?? "Something went wrong",
      );
      showDialog(
        context: context,
        builder: (_) => DialogBox(
          error: errorModel,
          type: DialogType.error,
          actions: [
            Padding(
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
                ),
                child: const Text("OK"),
              ),
            ),
          ],
        )
            .animate(
              autoPlay: true,
            )
            .fadeIn(
              duration: const Duration(milliseconds: 150),
              begin: 0,
            )
            .scaleXY(
              begin: 3,
              end: 1,
              duration: const Duration(milliseconds: 150),
            ),
      );
    }
  }
}
