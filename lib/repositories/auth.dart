import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '/repositories/collections.dart';
import '/models/user.dart';

class AuthRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<UserModel> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch User Data from Firebase Firestore...
      final DocumentSnapshot<Map<String, dynamic>> userData = await _firestore
          .collection(usersCollection)
          .doc(userCredential.user!.uid)
          .get();

      UserModel userModel = UserModel.fromMap(
        userData.data() ?? {},
      );

      // Fetch the UserProfile Photo from Firebase Storage...
      final Uint8List? photo = await _storage
          .ref()
          .child(profilePhotosBucket)
          .child("${userCredential.user!.uid}.jpg")
          .getData();

      userModel = userModel.copyWith(profilePhoto: photo);

      return userModel;
    } catch (err) {
      rethrow;
    }
  }

  static Future<UserModel> signup(
    String username,
    String email,
    String password,
    Uint8List? photo,
  ) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? photoPath;

      if (photo != null) {
        final ref = _storage
            .ref()
            .child(profilePhotosBucket)
            .child('${userCredential.user!.uid}.jpg');

        await ref.putData(photo);

        photoPath = await ref.getDownloadURL();
      }

      final UserModel userModel = UserModel(
        createdAt: DateTime.now(),
        username: username,
        email: email,
        profilePath: photoPath,
        friends: null,
      );

      await _firestore
          .collection(usersCollection)
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      return userModel;
    } catch (err) {
      rethrow;
    }
  }
}
