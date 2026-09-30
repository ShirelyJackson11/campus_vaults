import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Learning Material',
      'message':
          'New Introduction to Programming notes are now available.',
      'time': '10 minutes ago',
      'icon': Icons.menu_book_outlined,
      'read': false,
    },
    {
      'title': 'Course Update',
      'message':
          'Your Database Management Systems course has been updated.',
      'time': '2 hours ago',
      'icon': Icons.update_outlined,
      'read': false,
    },
    {
      'title': 'Download Complete',
      'message':
          'Web Design and Development notes have been downloaded.',
      'time': 'Yesterday',
      'icon': Icons.download_done_outlined,
      'read': true,
    },
    {
      'title': 'New Assignment',
      'message':
          'A new programming assignment has been added to CS101.',
      'time': 'Yesterday',
      'icon': Icons.assignment_outlined,
      'read': true,
    },
    {
      'title': 'Offline Reminder',
      'message':
          'Remember to download your learning materials before '
          'travelling to areas with limited internet access.',
      'time': '2 days ago',
      'icon': Icons.wifi_off_outlined,
      'read': true,
    },
  ];

  Future<void> _loadNotifications() async {
  final prefs = await SharedPreferences.getInstance();

  final savedNotifications =
      await NotificationService.getNotifications();

  final savedReadStates =
      prefs.getStringList('notification_read_states');

  if (!mounted) return;

  setState(() {
    // Add saved notifications to the beginning of the list.
    for (final savedNotification in savedNotifications.reversed) {
      final type = savedNotification['type'] as String? ?? '';

      IconData icon;

      switch (type) {
        case 'learning_material':
          icon = Icons.menu_book_outlined;
          break;
        case 'course_update':
          icon = Icons.update_outlined;
          break;
        case 'download':
          icon = Icons.download_done_outlined;
          break;
        case 'assignment':
          icon = Icons.assignment_outlined;
          break;
        case 'offline':
          icon = Icons.wifi_off_outlined;
          break;
        default:
          icon = Icons.notifications_outlined;
      }

      notifications.insert(0, {
        'title': savedNotification['title'] ?? '',
        'message': savedNotification['message'] ?? '',
        'time': savedNotification['time'] ?? '',
        'icon': icon,
        'read': savedNotification['read'] ?? false,
      });
    }

    // Keep the existing read-state functionality.
    if (savedReadStates != null) {
      for (int i = 0;
          i < notifications.length &&
              i < savedReadStates.length;
          i++) {
        notifications[i]['read'] =
            savedReadStates[i] == 'true';
      }
    }
  });

  }
Future<void> _saveNotifications() async {
  final prefs = await SharedPreferences.getInstance();

  final readStates = notifications
      .map((notification) => notification['read'].toString())
      .toList();

  await prefs.setStringList(
    'notification_read_states',
    readStates,
  );
}
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _markAsRead(int index) {
  setState(() {
    notifications[index]['read'] = true;
  });

  _saveNotifications();
}

  void _markAllAsRead() {
    setState(() {
      for (final notification in notifications) {
        notification['read'] = true;
      }
    });
    _saveNotifications();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read.'),
      ),
    );
  }

  void _deleteNotification(int index) {
    final title = notifications[index]['title'] as String;

    setState(() {
      notifications.removeAt(index);
    });
_saveNotifications();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title removed.'),
      ),
    );
  }

  void _clearAllNotifications() {
    if (notifications.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There are no notifications to clear.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Notifications'),
          content: const Text(
            'Are you sure you want to remove all notifications?',
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
                setState(() {
                  notifications.clear();
                });
_saveNotifications();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'All notifications have been removed.',
                    ),
                  ),
                );
              },
              child: const Text('CLEAR'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications
        .where(
          (notification) => notification['read'] == false,
        )
        .length;

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
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _clearAllNotifications,
            icon: const Icon(
              Icons.delete_sweep_outlined,
              color: Colors.black87,
            ),
            tooltip: 'Clear notifications',
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: SafeArea(
        child: notifications.isEmpty
            ? _emptyNotifications()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // Page heading
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      unreadCount == 0
                          ? 'You have no unread notifications.'
                          : 'You have $unreadCount unread '
                              'notification'
                              '${unreadCount == 1 ? '' : 's'}.',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Mark all as read
                    if (unreadCount > 0)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _markAllAsRead,
                          child: const Text(
                            'Mark All as Read',
                          ),
                        ),
                      ),

                    const SizedBox(height: 5),

                    // Notification list
                    ListView.separated(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemBuilder: (context, index) {
                        final notification =
                            notifications[index];

                        return _notificationCard(
                          index: index,
                          title:
                              notification['title'] as String,
                          message:
                              notification['message'] as String,
                          time:
                              notification['time'] as String,
                          icon:
                              notification['icon'] as IconData,
                          isRead:
                              notification['read'] as bool,
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    // Notification information
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notifications_active_outlined,
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
                                  'Stay Updated',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  'You will receive notifications about '
                                  'new learning materials, course updates, '
                                  'assignments and downloads.',
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

  // ---------------- NOTIFICATION CARD ----------------
  Widget _notificationCard({
    required int index,
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required bool isRead,
  }) {
    return Dismissible(
      key: ValueKey('$title-$index'),
      direction: DismissDirection.endToStart,

      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),

      onDismissed: (direction) {
        _deleteNotification(index);
      },

      child: InkWell(
        onTap: () {
          _markAsRead(index);
        },

        borderRadius: BorderRadius.circular(15),

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: isRead
                ? Colors.white
                : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isRead
                  ? Colors.grey.shade200
                  : Colors.blue.shade100,
            ),
          ),

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Notification icon
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: isRead
                      ? Colors.grey.shade100
                      : Colors.blue.shade100,
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,
                  color: isRead
                      ? Colors.grey.shade600
                      : Colors.blue.shade700,
                  size: 26,
                ),
              ),

              const SizedBox(width: 14),

              // Notification information
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isRead
                                  ? FontWeight.w600
                                  : FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        if (!isRead)
                          Container(
                            width: 9,
                            height: 9,
                            margin:
                                const EdgeInsets.only(
                              top: 5,
                              left: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Colors.blue.shade700,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- EMPTY NOTIFICATIONS ----------------
  Widget _emptyNotifications() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 70,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 20),

            const Text(
              'No Notifications',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'New course updates, learning materials '
              'and other notifications will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}