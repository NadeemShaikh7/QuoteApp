import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin
  _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // 1️⃣ Initialize timezone database
    tz.initializeTimeZones();

    // 2️⃣ Get device timezone
    final String timeZoneName =
    await FlutterNativeTimezone.getLocalTimezone();

    // 3️⃣ Set local timezone (THIS FIXES YOUR CRASH)
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // 4️⃣ Init notifications plugin
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
  }




  static Future<void> scheduleDailyQuote({
    required String quote,
    required String author,
    required TimeOfDay time,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // If time already passed today → schedule tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      0,
      'Quote of the Day',
      '$quote — $author',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_quote',
          'Daily Quote',
          channelDescription: 'Daily motivational quote',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      // androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,

      // 🔁 THIS MAKES IT DAILY
      matchDateTimeComponents: DateTimeComponents.time, androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  static Future<void> testNotification() async {
    await _notifications.show(
      999,
      'Test Notification',
      'If you see this, notifications work 🎉',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Channel',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
