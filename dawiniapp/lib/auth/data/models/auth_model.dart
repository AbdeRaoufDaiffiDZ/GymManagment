// ignore_for_file: annotate_overrides

import 'dart:convert';

import 'package:dawini_full/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  // ignore: overridden_fields
  final String email;
  // ignore: overridden_fields
  final String password;

  AuthModel({
    required this.email,
    required this.password,
  }) : super(
          email: email,
          password: password,
        );

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));
}
