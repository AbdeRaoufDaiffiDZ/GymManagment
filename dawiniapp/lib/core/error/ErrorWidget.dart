// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final errorMessage = getErrorMessage(error);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16),
          ),
          // Add retry button or other actions if needed
        ],
      ),
    );
  }
}

String getErrorMessage(error) {
  if (error is FirebaseException) {
    switch (error.code) {
      case "PERMISSION_DENIED":
        return "You don't have permission to access this data.";
      case "NOT_FOUND":
        return "The requested data doesn't exist.";
      default:
        return "An error occurred: ${error.message}";
    }
  } else if (error is SocketException) {
    return "Please check your internet connection.";
  } else if (error is FormatException) {
    return "Invalid data format encountered.";
  } else {
    return "An unknown error occurred.";
  }
}
