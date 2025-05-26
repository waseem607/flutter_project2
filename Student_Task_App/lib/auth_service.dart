import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthService extends ChangeNotifier {
  final List<User> _users = [];
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool registerUser(String name, String email, String password) {
    // Check if user already exists
    if (_users.any((user) => user.email == email)) {
      return false;
    }

    // Create new user
    final user = User(
      name: name,
      email: email,
      password: password,
    );

    // Add to users list
    _users.add(user);
    notifyListeners();
    return true;
  }

  bool loginUser(String email, String password) {
    try {
      // Find user with matching email and password
      final user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      
      _currentUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
} 