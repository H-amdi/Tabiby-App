import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class SpecialtyModel {
  final String id;
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const SpecialtyModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}

class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String specialtyId;
  final Color avatarColor;
  final String initials;
  final double rating;
  final int reviewCount;
  final List<String> availableTimes;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.specialtyId,
    required this.avatarColor,
    required this.initials,
    this.rating = 4.8,
    this.reviewCount = 120,
    required this.availableTimes,
  });
}

enum AppointmentStatus { upcoming, completed, cancelled }

extension AppointmentStatusExt on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.upcoming:
        return AppStrings.badgeUpcoming;
      case AppointmentStatus.completed:
        return AppStrings.badgeCompleted;
      case AppointmentStatus.cancelled:
        return AppStrings.badgeCancelled;
    }
  }

  Color get color {
    switch (this) {
      case AppointmentStatus.upcoming:
        return AppColors.statusUpcoming;
      case AppointmentStatus.completed:
        return AppColors.statusCompleted;
      case AppointmentStatus.cancelled:
        return AppColors.statusCancelled;
    }
  }

  Color get bgColor {
    switch (this) {
      case AppointmentStatus.upcoming:
        return const Color(0xFFE3F2FD);
      case AppointmentStatus.completed:
        return const Color(0xFFE8F5E9);
      case AppointmentStatus.cancelled:
        return const Color(0xFFFFEBEE);
    }
  }

  IconData get icon {
    switch (this) {
      case AppointmentStatus.upcoming:
        return Icons.schedule;
      case AppointmentStatus.completed:
        return Icons.check_circle_outline;
      case AppointmentStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}

class AppointmentModel {
  final String id;
  final DoctorModel doctor;
  final String specialty;
  final String date;
  final String time;
  final AppointmentStatus status;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
  });

  AppointmentModel copyWith({
    String? id,
    DoctorModel? doctor,
    String? specialty,
    String? date,
    String? time,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      specialty: specialty ?? this.specialty,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum NotificationType { booking, cancellation, reminder }

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  final NotificationType type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.createdAt,
    required this.type,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
      type: type,
    );
  }

  IconData get icon {
    switch (type) {
      case NotificationType.booking:
        return Icons.check_circle_outline;
      case NotificationType.cancellation:
        return Icons.cancel_outlined;
      case NotificationType.reminder:
        return Icons.notifications_outlined;
    }
  }

  Color get iconColor {
    switch (type) {
      case NotificationType.booking:
        return AppColors.success;
      case NotificationType.cancellation:
        return AppColors.error;
      case NotificationType.reminder:
        return AppColors.primary;
    }
  }
}

class DaySlot {
  final String dayName;
  final int dayNumber;
  final String month;

  const DaySlot({
    required this.dayName,
    required this.dayNumber,
    required this.month,
  });

  String get full => '${dayName}، $dayNumber $month';
}

class TimeSlot {
  final String time;
  final String period;

  const TimeSlot({required this.time, required this.period});

  String get full => '$time $period';
}

class UserProfileModel {
  final String name;
  final String fileNo;
  final String phone;
  final String email;
  final String bloodType;
  final String allergy;
  final String chronicDiseases;
  final String emergencyContact;
  final String emergencyPhone;

  const UserProfileModel({
    required this.name,
    required this.fileNo,
    required this.phone,
    required this.email,
    required this.bloodType,
    required this.allergy,
    required this.chronicDiseases,
    required this.emergencyContact,
    required this.emergencyPhone,
  });

  UserProfileModel copyWith({
    String? name,
    String? fileNo,
    String? phone,
    String? email,
    String? bloodType,
    String? allergy,
    String? chronicDiseases,
    String? emergencyContact,
    String? emergencyPhone,
  }) {
    return UserProfileModel(
      name: name ?? this.name,
      fileNo: fileNo ?? this.fileNo,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bloodType: bloodType ?? this.bloodType,
      allergy: allergy ?? this.allergy,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
    );
  }
}
