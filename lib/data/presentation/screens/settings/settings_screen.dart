import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/notification_service.dart';
import '../../controllers/quote_controller.dart';
import '../../controllers/setting_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController settingsController =
  Get.find<SettingsController>();
  final QuoteController quoteController =
  Get.find<QuoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Obx(() {
        final notificationTime =
            settingsController.notificationTime.value;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --------------------------------------------------
            // 🔔 Daily Quote Notification (EXISTING FEATURE)
            // --------------------------------------------------
            ListTile(
              title: const Text('Daily Quote Notification'),
              subtitle: Text(
                'Time: ${notificationTime.hour}:${notificationTime.minute.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.schedule),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: notificationTime,
                );

                if (picked != null &&
                    quoteController.dailyQuote.value != null) {
                  settingsController
                      .updateNotificationTime(picked);

                  final quote =
                  quoteController.dailyQuote.value!;
                  await NotificationService.scheduleDailyQuote(
                    quote: quote.text,
                    author: quote.author,
                    time: picked,
                  );
                }
              },
            ),

            const Divider(height: 32),

            // --------------------------------------------------
            // 🌗 Dark / Light Mode
            // --------------------------------------------------
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: settingsController.isDarkMode.value,
              onChanged: settingsController.toggleTheme,
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // 🔤 Font Size Adjustment
            // --------------------------------------------------
            Text(
              'Quote Font Size',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: settingsController.fontScale.value,
              min: 0.8,
              max: 1.4,
              divisions: 6,
              label: settingsController.fontScale.value
                  .toStringAsFixed(1),
              onChanged:
              settingsController.updateFontScale,
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // 🎨 Accent Color Selection
            // --------------------------------------------------
            Text(
              'Accent Color',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: List.generate(
                settingsController.accentColors.length,
                    (index) {
                  final color = Color(
                    settingsController.accentColors[index],
                  );

                  final isSelected =
                      settingsController.accentIndex.value ==
                          index;

                  return GestureDetector(
                    onTap: () =>
                        settingsController.updateAccent(index),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: color,
                      child: isSelected
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
