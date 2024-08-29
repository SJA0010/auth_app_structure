import 'package:flutter/material.dart';

class GreetingProvider extends ChangeNotifier {
  String _greeting = '';

  String get greeting => _greeting;

  GreetingProvider() {
    _updateGreeting();
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      _greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      _greeting = 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      _greeting = 'Good Evening';
    } else {
      _greeting = 'Good Night';
    }

    notifyListeners();
  }

  void refreshGreeting() {
    _updateGreeting();
  }
}
