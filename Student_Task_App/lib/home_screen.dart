import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'auth_service.dart';
import 'enrollment_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> availableCourses = [
    {
      'title': 'Flutter Development',
      'instructor': 'John Doe',
      'duration': '8 weeks',
      'price': '\$49.99',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'title': 'Web Development',
      'instructor': 'Jane Smith',
      'duration': '10 weeks',
      'price': '\$59.99',
      'image': 'https://picsum.photos/200/301',
    },
    {
      'title': 'Data Science',
      'instructor': 'Mike Johnson',
      'duration': '12 weeks',
      'price': '\$69.99',
      'image': 'https://picsum.photos/200/302',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, _) {
        final currentUser = authService.currentUser;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Student Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // TODO: Implement notifications
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 35, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentUser?.name ?? 'Student Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        currentUser?.email ?? 'student@email.com',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // TODO: Navigate to profile
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    authService.logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          body: _selectedIndex == 0
              ? _buildAvailableCourses()
              : _buildMyCourses(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Available Courses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'My Courses',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvailableCourses() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: availableCourses.length,
      itemBuilder: (context, index) {
        final course = availableCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                course['image'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Instructor: ${course['instructor']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Duration: ${course['duration']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Price: ${course['price']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnrollmentForm(
                                course: course,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Enroll Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMyCourses() {
    final authService = Provider.of<AuthService>(context);
    final enrolledCourses = authService.getEnrolledCourses();

    if (enrolledCourses.isEmpty) {
      return const Center(
        child: Text(
          'No courses enrolled yet',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: enrolledCourses.length,
      itemBuilder: (context, index) {
        final course = enrolledCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                course['image'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Instructor: ${course['instructor']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Duration: ${course['duration']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement course content viewing
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Course content coming soon!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Start Learning'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
