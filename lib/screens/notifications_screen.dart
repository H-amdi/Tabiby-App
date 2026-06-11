import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

import '../providers/notification_provider.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.notifTitle,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          // Show menu only when there are notifications
          if (provider.all.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.white),
              onSelected: (value) {
                if (value == 'markAll') {
                  provider.markAllAsRead();
                } else if (value == 'clearAll') {
                  _showClearDialog(context, provider);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'markAll',
                  child: Text(
                    AppStrings.markAllRead,
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'clearAll',
                  child: Text(
                    AppStrings.clearAll,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: provider.all.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.notifications_off_outlined,
              message: AppStrings.noNotif,
              subMessage: 'ستظهر الإشعارات هنا بعد حجز موعد أو إلغائه',
            )
          : Column(
              children: [
                // Unread banner (shows only when there are unread)
                if (provider.hasUnread)
                  Container(
                    color: AppColors.primaryLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: provider.markAllAsRead,
                          child: const Text(
                            AppStrings.markAllRead,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${provider.unreadCount} ${AppStrings.unread}',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: AppColors.textMedium,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.circle,
                              color: AppColors.primary,
                              size: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                //  Notification list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.all.length,
                    itemBuilder: (_, i) {
                      final notif = provider.all[i];
                      return NotificationTile(
                        notification: notif,
                        // Tapping marks it as read
                        onTap: () => provider.markAsRead(notif.id),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // Confirmation dialog before clearing all
  void _showClearDialog(BuildContext context, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'مسح الإشعارات',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        content: const Text(
          'هل أنت متأكد من مسح جميع الإشعارات؟',
          style: TextStyle(fontFamily: 'Cairo'),
          textAlign: TextAlign.right,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.textMedium,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.clearAll();
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'مسح الكل',
              style: TextStyle(fontFamily: 'Cairo', color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
