import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
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
        currentIndex: 0,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              children: [
                _buildOverviewCard(
                  color: Colors.blue[50],
                  icon: Icons.people,
                  title: 'Total Students',
                  value: '31',
                  iconColor: Colors.blue,
                ),
                SizedBox(width: 12),
                _buildOverviewCard(
                  color: Colors.orange[50],
                  icon: Icons.task,
                  title: 'Total Tasks',
                  value: '9',
                  iconColor: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildOverviewCard(
                  color: Colors.green[50],
                  icon: Icons.check_circle,
                  title: 'Completed',
                  value: '18',
                  iconColor: Colors.green,
                ),
                SizedBox(width: 12),
                _buildOverviewCard(
                  color: Colors.red[50],
                  icon: Icons.cancel,
                  title: 'Pending',
                  value: '27',
                  iconColor: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('Task Completion Rate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildProgressBar(0.4),
            SizedBox(height: 24),
            Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildActivityTile('wt', 'Completed by Wes', '2025-05-27 04:37:06'),
            // Add more activities here
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard({Color? color, IconData? icon, String? title, String? value, Color? iconColor}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 32),
            SizedBox(height: 8),
            Text(title ?? '', style: TextStyle(fontSize: 14, color: Colors.black54)),
            SizedBox(height: 4),
            Text(value ?? '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: iconColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(double value) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 8,
        ),
        SizedBox(height: 8),
        Text('${(value * 100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActivityTile(String title, String subtitle, String date) {
    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.purple),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
} 