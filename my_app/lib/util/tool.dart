import 'package:flutter/material.dart';

void logWithTime(String message) {
  final currentTime = DateTime.now().toIso8601String();
  debugPrint('[$currentTime] $message');
}

bool isEmptyOrNull(String? value) {
  return value == null || value.trim().isEmpty;
}
