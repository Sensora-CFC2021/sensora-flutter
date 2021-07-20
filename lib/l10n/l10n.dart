import 'package:flutter/material.dart';

class L10n {
  static final all = [const Locale('en'), const Locale('mn')];
  static String getFlag(code) {
    switch (code) {
      case 'mn':
        return '🇲🇳';
      case 'en':
      default:
        return '🇬🇧';
    }
  }
}
