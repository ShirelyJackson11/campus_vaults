import 'package:flutter/material.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  void _openCourse(String courseName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$courseName selected.'),
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Courses',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ---------------- BODY ----------------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Page introduction
              const Text(
                'My Courses',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Access the courses you are currently studying.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              // Course count
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.menu_book,
                        size: 30,
                        color: Colors.blue.shade700,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4 Courses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Currently enrolled',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Course section
              const Text(
                'Enrolled Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 15),

              // Course 1
              _courseCard(
                courseCode: 'CS101',
                courseName: 'Introduction to Programming',
                lecturer: 'Computer Science',
                progress: 0.75,
                icon: Icons.code,
                onTap: () {
                  _openCourse(
                    'Introduction to Programming',
                  );
                },
              ),

              const SizedBox(height: 15),

              // Course 2
              _courseCard(
                courseCode: 'DB201',
                courseName: 'Database Management Systems',
                lecturer: 'Information Technology',
                progress: 0.60,
                icon: Icons.storage_outlined,
                onTap: () {
                  _openCourse(
                    'Database Management Systems',
                  );
                },
              ),

              const SizedBox(height: 15),

              // Course 3
              _courseCard(
                courseCode: 'WD301',
                courseName: 'Web Design and Development',
                lecturer: 'Information Technology',
                progress: 0.85,
                icon: Icons.web_outlined,
                onTap: () {
                  _openCourse(
                    'Web Design and Development',
                  );
                },
              ),

              const SizedBox(height: 15),

              // Course 4
              _courseCard(
                courseCode: 'MA102',
                courseName: 'Mathematics for Computing',
                lecturer: 'Mathematics',
                progress: 0.45,
                icon: Icons.calculate_outlined,
                onTap: () {
                  _openCourse(
                    'Mathematics for Computing',
                  );
                },
              ),

              const SizedBox(height: 25),

              // Offline learning message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.cloud_download_outlined,
                      size: 30,
                      color: Colors.blue.shade700,
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Study Offline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Download course materials so you '
                            'can continue studying when internet '
                            'access is limited.',
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
    );
  }

  // ---------------- COURSE CARD ----------------
  Widget _courseCard({
    required String courseCode,
    required String courseName,
    required String lecturer,
    required double progress,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // Icon and course code
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: Colors.blue.shade700,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseCode,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        courseName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
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

            const SizedBox(height: 15),

            // Department
            Text(
              lecturer,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 15),

            // Progress
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Course Progress',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.shade200,
              color: Colors.blue.shade700,
            ),
          ],
        ),
      ),
    );
  }
}