import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'students_screen.dart';

class TasksScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Statistics Assignment 3',
      'due': '2025-05-26',
      'completed': 8,
      'total': 9,
    },
    {
      'title': 'Linear algebra Assignment 3',
      'due': '2025-05-26',
      'completed': 0,
      'total': 4,
    },
    {
      'title': 'SRE ASSIGNMENT 3',
      'due': '2025-05-27',
      'completed': 2,
      'total': 6,
    },
    {
      'title': 'Due in 3 Days',
      'due': '2025-05-29',
      'completed': 1,
      'total': 6,
    },
    {
      'title': 'Due Next Week',
      'due': '2025-06-02',
      'completed': 2,
      'total': 7,
    },
  ];

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StudentsScreen()),
      );
    } else if (index == 2) {
      // Already on TasksScreen
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
        currentIndex: 2,
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (_, __) => SizedBox(height: 16),
          itemBuilder: (context, index) {
            final task = tasks[index];
            final double progress = task['total'] > 0 ? task['completed'] / task['total'] : 0.0;
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange[100],
                        child: Icon(Icons.access_time, color: Colors.orange),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task['title'],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: 'Due: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: task['due'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Progress: ${task['completed']}/${task['total']} completed',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
} 