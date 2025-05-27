import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'student_app.db');
      debugPrint('Initializing database at: $path');

      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onOpen: (db) {
          debugPrint('Database opened successfully');
        },
      );
    } catch (e) {
      debugPrint('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      // Create users table
      await db.execute('''        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL,
          registration_date TEXT NOT NULL
        )
      ''');
      debugPrint('Users table created successfully');

      // Create enrolled_courses table
      await db.execute('''
        CREATE TABLE enrolled_courses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          title TEXT NOT NULL,
          instructor TEXT NOT NULL,
          duration TEXT NOT NULL,
          price TEXT NOT NULL,
          image TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id)
        )
      ''');
      debugPrint('Enrolled courses table created successfully');
    } catch (e) {
      debugPrint('Error creating database tables: $e');
      rethrow;
    }
  }

  // User operations with error handling
  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      final id = await db.insert('users', user);
      debugPrint('User inserted successfully with id: $id');
      return id;
    } catch (e) {
      debugPrint('Error inserting user: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      debugPrint('User query returned ${maps.length} results');
      if (maps.isEmpty) return null;
      return maps.first;
    } catch (e) {
      debugPrint('Error getting user: $e');
      rethrow;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      return maps.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking email existence: $e');
      rethrow;
    }
  }

  // Enrolled courses operations with error handling
  Future<int> enrollCourse(int userId, Map<String, dynamic> course) async {
    try {
      final db = await database;
      final courseData = {
        'user_id': userId,
        'title': course['title'],
        'instructor': course['instructor'],
        'duration': course['duration'],
        'price': course['price'],
        'image': course['image'],
      };
      final id = await db.insert('enrolled_courses', courseData);
      debugPrint('Course enrolled successfully with id: $id');
      return id;
    } catch (e) {
      debugPrint('Error enrolling in course: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getEnrolledCourses(int userId) async {
    try {
      final db = await database;
      final courses = await db.query(
        'enrolled_courses',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      debugPrint('Found ${courses.length} enrolled courses for user $userId');
      return courses;
    } catch (e) {
      debugPrint('Error getting enrolled courses: $e');
      rethrow;
    }
  }

  Future<bool> isEnrolled(int userId, String courseTitle) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'enrolled_courses',
        where: 'user_id = ? AND title = ?',
        whereArgs: [userId, courseTitle],
      );
      debugPrint('Enrollment check returned ${maps.length} results');
      return maps.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking course enrollment: $e');
      rethrow;
    }
  }
}
