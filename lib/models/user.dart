// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? username;
  final String? email;
  final String? profilePath;
  final Uint8List? profilePhoto;
  final List<String>? friends;
  final DateTime? createdAt;

  const UserModel({
    this.username,
    this.email,
    this.profilePath,
    this.friends,
    this.createdAt,
    this.profilePhoto,
  });

  static UserModel get empty => const UserModel();

  UserModel copyWith({
    String? username,
    String? email,
    String? profilePath,
    Uint8List? profilePhoto,
    List<String>? friends,
    DateTime? createdAt,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      profilePath: profilePath ?? this.profilePath,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      friends: friends ?? this.friends,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      username,
      email,
      profilePath,
      profilePhoto,
      friends,
      createdAt,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'profilePhoto': profilePath,
      'friends': friends,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profilePath:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
      friends: map['friends'] != null
          ? List<String>.from((map['friends'] as List<String>))
          : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
