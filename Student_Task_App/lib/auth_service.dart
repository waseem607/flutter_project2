import 'package:flutter/material.dart';
import 'database_helper.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final DateTime registrationDate;
  final List<Map<String, dynamic>> enrolledCourses;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.registrationDate,
    List<Map<String, dynamic>>? enrolledCourses,
  }) : enrolledCourses = enrolledCourses ?? [];
}

class AuthService extends ChangeNotifier {
  User? _currentUser;
  final DatabaseHelper _db = DatabaseHelper();

  User? get currentUser => _currentUser;

  Future<bool> registerUser(String name, String email, String password) async {
    // Check if user already exists
    final exists = await _db.checkEmailExists(email);
    if (exists) {
      return false;
    }

    // Create new user with registration timestamp
    final registrationDate = DateTime.now();
    final userId = await _db.insertUser({
      'name': name,
      'email': email,
      'password': password,
      'registration_date': registrationDate.toIso8601String(),
    });

    _currentUser = User(
      id: userId,
      name: name,
      email: email,
      password: password,
      registrationDate: registrationDate,
    );

    notifyListeners();
    return true;
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final user = await _db.getUser(email, password);
      if (user == null) return false;

      final enrolledCourses = await _db.getEnrolledCourses(user['id'] as int);

      _currentUser = User(
        id: user['id'] as int,
        name: user['name'] as String,
        email: user['email'] as String,
        password: user['password'] as String,
        registrationDate: DateTime.parse(user['registration_date']),
        enrolledCourses: enrolledCourses,
      );

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

  Future<bool> enrollInCourse(Map<String, dynamic> course) async {
    if (_currentUser == null) return false;

    try {
      // Check if already enrolled
      final isEnrolled =
          await _db.isEnrolled(_currentUser!.id, course['title']);
      if (isEnrolled) {
        return false;
      }

      // Add course to enrolled courses
      await _db.enrollCourse(_currentUser!.id, course);

      // Refresh enrolled courses
      final enrolledCourses = await _db.getEnrolledCourses(_currentUser!.id);

      // Update current user
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: _currentUser!.email,
        password: _currentUser!.password,
        registrationDate: _currentUser!.registrationDate,
        enrolledCourses: enrolledCourses,
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Map<String, dynamic>> getEnrolledCourses() {
    return _currentUser?.enrolledCourses ?? [];
  }
}
