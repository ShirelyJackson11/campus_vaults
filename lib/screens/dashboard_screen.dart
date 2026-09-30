import 'package:flutter/material.dart';
import 'my_course_screen.dart';
import 'learning_materials_screen.dart';
import 'downloads_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Campus Vaults',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              
              Navigator.push(
                 context,
               MaterialPageRoute(
                   builder: (context) => const NotificationScreen(),
               ),
             );
             },
            
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
            ),
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Welcome section
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Continue learning and access your study materials.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              // Search bar
              TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search learning materials...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Quick access title
              const Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 15),

              // Quick access cards
              Row(
                children: [
                  Expanded(
                    child: _quickAccessCard(
                      icon: Icons.menu_book_outlined,
                      title: 'My Courses',
                      onTap: () {
                        
                         Navigator.push(
                                  context,
                           MaterialPageRoute(
                       builder: (context) => const MyCourseScreen(),
                      ),
                       );
                        },

                      
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _quickAccessCard(
                      icon: Icons.description_outlined,
                      title: 'Materials',
                      onTap: () {
                        Navigator.push(
                           context,
                         MaterialPageRoute(
                        builder: (context) => const LearningMaterialsScreen(),
                        ),
                        );
                        },
                      
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _quickAccessCard(
                      icon: Icons.download_outlined,
                      title: 'Downloads',
                      onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                       builder: (context) => const DownloadsScreen(),
                       ),
                      );

                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _quickAccessCard(
                      icon: Icons.person_outline,
                      title: 'Profile',
                      onTap: () {
  
                      Navigator.push(
                          context,
                     MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                      ),
                      );

                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Recent materials
              const Text(
                'Recent Learning Materials',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 15),

              _materialCard(
                icon: Icons.picture_as_pdf_outlined,
                title: 'Introduction to Programming',
                subtitle: 'Lecture Notes • PDF',
                onTap: () {
                  _showMessage(
                    'Learning material selected.',
                  );
                },
              ),

              const SizedBox(height: 12),

              _materialCard(
                icon: Icons.menu_book_outlined,
                title: 'Database Management Systems',
                subtitle: 'Study Material • PDF',
                onTap: () {
                  _showMessage(
                    'Learning material selected.',
                  );
                },
              ),

              const SizedBox(height: 12),

              _materialCard(
                icon: Icons.article_outlined,
                title: 'Web Design and Development',
                subtitle: 'Course Notes • PDF',
                onTap: () {
                  _showMessage(
                    'Learning material selected.',
                  );
                },
              ),

              const SizedBox(height: 25),

              // Offline learning information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.wifi_off_outlined,
                      size: 32,
                      color: Colors.blue.shade700,
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Learn Offline',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Download your learning materials and '
                            'access them even when you have limited '
                            'internet connectivity.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBar:NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
  setState(() {
    _selectedIndex = index;
  });

  if (index == 0) {
    return;
  } else if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyCourseScreen(),
      ),
    );
  } else if (index == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DownloadsScreen(),
      ),
    );
  } else if (index == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }
},
      destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),

          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Courses',
          ),

          NavigationDestination(
            icon: Icon(Icons.download_outlined),
            selectedIcon: Icon(Icons.download),
            label: 'Downloads',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ---------------- QUICK ACCESS CARD ----------------
  Widget _quickAccessCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.blue.shade700,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- MATERIAL CARD ----------------
  Widget _materialCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.blue.shade700,
                size: 28,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}