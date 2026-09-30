import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationsEnabled = true;

  String studentName = 'Student User';
  String studentEmail = 'student@campusvaults.com';
  String studentId = '';
  Future<void> _loadStudentProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final savedName = prefs.getString('student_name');
    final savedEmail = prefs.getString('student_email');
    final savedStudentId = prefs.getString('student_id');

    if (!mounted) return;

    setState(() {
      studentName = savedName ?? 'Student User';
      studentEmail = savedEmail ?? 'student@campusvaults.com';
      studentId = savedStudentId ?? '';
    });
  }
    @override
  void initState() {
    super.initState();
    _loadStudentProfile();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile editing will be available here.',
        ),
      ),
    );
  }

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Change password will be available here.',
        ),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text(
            'Are you sure you want to log out of Campus Vaults?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                _showMessage(
                  'Logout functionality will be connected later.',
                );
              },
              child: const Text('LOG OUT'),
            ),
          ],
        );
      },
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
          'Profile',
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
            children: [

              // ---------------- PROFILE HEADER ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [

                    // Profile picture
                    Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 55,
                        color: Colors.blue.shade700,
                      ),
                    ),

                    const SizedBox(height: 15),

                     Text(
  studentName,
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  ),
),

const SizedBox(height: 5),

Text(
  studentEmail,
  style: const TextStyle(
    fontSize: 14,
    color: Colors.black54,
  ),
),

                    if (studentId.isNotEmpty) ...[
  const SizedBox(height: 5),

  Text(
    'Student ID: $studentId',
    style: const TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
  ),
],

const SizedBox(height: 5),

const Text(
  'Computer Science Student',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: _editProfile,
                        icon: const Icon(
                          Icons.edit_outlined,
                        ),
                        label: const Text(
                          'EDIT PROFILE',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              Colors.blue.shade700,
                          side: BorderSide(
                            color: Colors.blue.shade700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- ACCOUNT ----------------
              _sectionTitle('Account'),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.person_outline,
                title: 'Personal Information',
                subtitle:
                    'View and update your personal details',
                onTap: () {
                  _showMessage(
                    'Personal information will open here.',
                  );
                },
              ),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle:
                    'Update your account password',
                onTap: _changePassword,
              ),

              const SizedBox(height: 25),

              // ---------------- APP SETTINGS ----------------
              _sectionTitle('App Settings'),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle:
                    'Manage your notification preferences',
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    notificationsEnabled =
                        !notificationsEnabled;
                  });
                },
              ),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.download_outlined,
                title: 'Download Settings',
                subtitle:
                    'Manage downloaded learning materials',
                onTap: () {
                  _showMessage(
                    'Download settings will open here.',
                  );
                },
              ),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  _showMessage(
                    'Language settings will open here.',
                  );
                },
              ),

              const SizedBox(height: 25),

              // ---------------- INFORMATION ----------------
              _sectionTitle('Information'),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.help_outline,
                title: 'Help and Support',
                subtitle:
                    'Get help with Campus Vaults',
                onTap: () {
                  _showMessage(
                    'Help and Support will open here.',
                  );
                },
              ),

              const SizedBox(height: 10),

              _profileOption(
                icon: Icons.info_outline,
                title: 'About Campus Vaults',
                subtitle:
                    'Learn more about the application',
                onTap: () {
                  _showAboutDialog();
                },
              ),

              const SizedBox(height: 25),

              // ---------------- LOGOUT ----------------
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(
                    Icons.logout,
                  ),
                  label: const Text(
                    'LOG OUT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade600,
                    side: BorderSide(
                      color: Colors.red.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // App version
              const Text(
                'Campus Vaults',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- SECTION TITLE ----------------
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ---------------- PROFILE OPTION ----------------
  Widget _profileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [

            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.blue.shade700,
                size: 25,
              ),
            ),

            const SizedBox(width: 14),

            // Text
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
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Optional trailing widget
            if (trailing != null)
              trailing
            else
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- ABOUT DIALOG ----------------
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About Campus Vaults'),
          content: const Text(
            'Campus Vaults is a mobile learning application '
            'designed to help students access and manage '
            'learning materials, including when internet '
            'connectivity is limited.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
}