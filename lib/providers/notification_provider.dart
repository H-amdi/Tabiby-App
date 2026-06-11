import 'package:flutter/material.dart';
import '../models/app_models.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  //  Getters
  List<NotificationModel> get all => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  bool get hasUnread => unreadCount > 0;

  //  Actions

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  /// Auto-generates a booking confirmation notification
  void addBookingNotification(String doctorName, String date, String time) {
    addNotification(
      NotificationModel(
        id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
        title: 'تأكيد الموعد',
        body: 'تم تأكيد موعدك مع $doctorName يوم $date الساعة $time',
        createdAt: DateTime.now(),
        type: NotificationType.booking,
      ),
    );
  }

  /// Auto-generates a cancellation notification
  void addCancellationNotification(String doctorName) {
    addNotification(
      NotificationModel(
        id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
        title: 'إلغاء الموعد',
        body: 'تم إلغاء موعدك مع $doctorName',
        createdAt: DateTime.now(),
        type: NotificationType.cancellation,
      ),
    );
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      if (!_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    }
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  String generateId() => 'notif_${DateTime.now().millisecondsSinceEpoch}';
}
