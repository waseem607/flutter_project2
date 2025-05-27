import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class StudentsScreen extends StatelessWidget {
  final List<Map<String, String>> students = [
    {'name': 'Waseem', 'email': 'waseem@example.com', 'reg': 'STU001'},
    {'name': 'Bob Johnson', 'email': 'bob2@example.com', 'reg': 'STU002'},
    {'name': 'Charlie Brown', 'email': 'charlie@example.com', 'reg': 'STU003'},
    {'name': 'Ahmad', 'email': 'ahmad@example.com', 'reg': 'STU004'},
    {'name': 'Abbass', 'email': 'abbass@example.com', 'reg': 'STU005'},
    {'name': 'Ijaz', 'email': 'ijaz@example.com', 'reg': 'STU006'},
  ];

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else if (index == 1) {
      // Already on StudentsScreen
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TasksScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) => _onNavTap(context, index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[100],
        child: Icon(Icons.add, color: Colors.purple),
        onPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or registration number',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: students.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[200],
                        child: Text(
                          student['name']![0].toUpperCase(),
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(student['name']!),
                      subtitle: Text(student['email']!),
                      trailing: Text(
                        student['reg']!,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for TasksScreen
class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Center(child: Text('Tasks Screen')),
    );
  }
} 