import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String _notificationsKey = 'app_notifications';

  // Save a new notification.
  static Future<void> addNotification({
    required String title,
    required String message,
    required String time,
    required String type,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final savedNotifications =
        prefs.getStringList(_notificationsKey) ?? [];

    final notification = jsonEncode({
      'title': title,
      'message': message,
      'time': time,
      'type': type,
      'read': false,
    });

    savedNotifications.insert(0, notification);

    await prefs.setStringList(
      _notificationsKey,
      savedNotifications,
    );
  }

  // Get all saved notifications.
  static Future<List<Map<String, dynamic>>>
      getNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    final savedNotifications =
        prefs.getStringList(_notificationsKey) ?? [];

    final List<Map<String, dynamic>> notifications = [];

    for (final item in savedNotifications) {
      try {
        final data = jsonDecode(item);

        notifications.add(
          Map<String, dynamic>.from(data),
        );
      } catch (_) {
        // Ignore invalid notification data.
      }
    }

    return notifications;
  }

  // Remove all saved notifications.
  static Future<void> clearNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_notificationsKey);
  }
}