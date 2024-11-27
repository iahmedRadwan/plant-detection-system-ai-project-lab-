import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

class ToastManager {
  /// Error Toast
  static void customToastError({
    required BuildContext context,
    required String title,
    String? description,
  }) => CherryToast.error(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        description: description != null
            ? Text(
                description,
                style: const TextStyle(fontSize: 12),
              )
            : null,
        animationDuration: const Duration(milliseconds: 1000),
        toastDuration: const Duration(milliseconds: 5000),
        displayCloseButton: false,
      ).show(context);
  /// Warning Toast
  static void customToastWarning({
    required BuildContext context,
    required String title,
    String? description,
  }) => CherryToast.warning(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        description: description != null
            ? Text(
                description,
                style: const TextStyle(fontSize: 12),
              )
            : null,
        animationDuration: const Duration(milliseconds: 1000),
        toastDuration: const Duration(milliseconds: 5000),
        displayCloseButton: false,
      ).show(context);
  /// Success Toast
  static void customToastSuccess({
    required BuildContext context,
    required String title,
    String? description,
  }) => CherryToast.success(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        description: description != null
            ? Text(
                description,
                style: const TextStyle(fontSize: 12),
              )
            : null,
        animationDuration: const Duration(milliseconds: 1000),
        toastDuration: const Duration(milliseconds: 5000),
        displayCloseButton: false,
      ).show(context);
}
