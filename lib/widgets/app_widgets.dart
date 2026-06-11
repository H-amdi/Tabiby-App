import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'common_widgets.dart';


class SpecialtyCard extends StatelessWidget {
  final SpecialtyModel specialty;
  final VoidCallback onTap;

  const SpecialtyCard({super.key, required this.specialty, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8, offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: specialty.bgColor, shape: BoxShape.circle,
              ),
              child: Icon(specialty.icon, color: specialty.iconColor, size: 28),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                specialty.name,
                style: const TextStyle(
                  fontFamily: 'Cairo', fontSize: 12,
                  fontWeight: FontWeight.w600, color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
                maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;

  const DoctorCard({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8, offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 16),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(doctor.name, style: AppTextStyles.doctorName),
                const SizedBox(height: 4),
                Text(doctor.specialty, style: AppTextStyles.specialtyLabel),
                const SizedBox(height: 6),
                RatingStars(rating: doctor.rating, reviewCount: doctor.reviewCount),
              ],
            ),
            const SizedBox(width: 14),
            DoctorAvatar(doctor: doctor, radius: 32),
          ],
        ),
      ),
    );
  }
}


class DayPickerCard extends StatelessWidget {
  final DaySlot day;
  final bool isSelected;
  final VoidCallback onTap;

  const DayPickerCard({
    super.key, required this.day,
    required this.isSelected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 68,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8, offset: const Offset(0, 3),
                )]
              : [],
        ),
        child: Column(
          children: [
            Text(
              day.dayName,
              style: TextStyle(
                fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              day.dayNumber.toString(),
              style: TextStyle(
                fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              day.month,
              style: TextStyle(
                fontFamily: 'Cairo', fontSize: 10,
                color: isSelected
                    ? AppColors.white.withValues(alpha: 0.8)
                    : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TimeSlotCard extends StatelessWidget {
  final TimeSlot slot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key, required this.slot,
    required this.isSelected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : AppColors.primary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 6, offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: AppColors.white, size: 16),
            const Spacer(),
            Text('${slot.period}   ${slot.time}', style: AppTextStyles.timeText),
          ],
        ),
      ),
    );
  }
}


class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key, required this.appointment, this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10, offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top colored bar ──
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: appointment.status.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Doctor info row
                Row(
                  children: [
                    StatusBadge(status: appointment.status),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(appointment.doctor.name,
                            style: AppTextStyles.doctorName),
                        const SizedBox(height: 2),
                        Text(appointment.specialty,
                            style: AppTextStyles.specialtyLabel),
                      ],
                    ),
                    const SizedBox(width: 12),
                    DoctorAvatar(doctor: appointment.doctor, radius: 26),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(color: AppColors.divider, height: 1),
                const SizedBox(height: 12),
                // Date + Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoChip(
                      icon: Icons.access_time_outlined,
                      label: appointment.time,
                    ),
                    Container(width: 1, height: 30, color: AppColors.divider),
                    _InfoChip(
                      icon: Icons.calendar_today_outlined,
                      label: appointment.date,
                    ),
                  ],
                ),
                // Cancel button (only for upcoming)
                if (appointment.status == AppointmentStatus.upcoming &&
                    onCancel != null) ...[
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: onCancel,
                      icon: const Icon(Icons.cancel_outlined,
                          color: AppColors.error, size: 18),
                      label: const Text(
                        'إلغاء الموعد',
                        style: TextStyle(
                          fontFamily: 'Cairo', fontSize: 14,
                          color: AppColors.error, fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(
              fontFamily: 'Cairo', fontSize: 13,
              color: AppColors.textDark, fontWeight: FontWeight.w500,
            )),
        const SizedBox(width: 6),
        Icon(icon, color: AppColors.primary, size: 16),
      ],
    );
  }
}


class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key, required this.notification, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.white
              : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: notification.isRead
                ? AppColors.divider
                : AppColors.primaryMid.withValues(alpha: 0.4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6, offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!notification.isRead)
              Container(
                width: 8, height: 8, margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle,
                ),
              ),
            if (!notification.isRead) const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(notification.title,
                      style: AppTextStyles.heading3.copyWith(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(notification.body,
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.right),
                  const SizedBox(height: 6),
                  Text(
                    _formatTime(notification.createdAt),
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: notification.iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(notification.icon,
                  color: notification.iconColor, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inHours < 1) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inDays < 1) return 'منذ ${diff.inHours} ساعة';
    return 'منذ ${diff.inDays} يوم';
  }
}
