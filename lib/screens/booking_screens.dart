// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../models/app_models.dart';
import '../providers/appointment_provider.dart';
import '../providers/notification_provider.dart';
import '../widgets/common_widgets.dart';
import 'splash_home_screen.dart';


class BookingSummaryScreen extends StatelessWidget {
  final DoctorModel doctor;
  final String specialty;
  final DaySlot day;
  final TimeSlot time;

  const BookingSummaryScreen({
    super.key,
    required this.doctor,
    required this.specialty,
    required this.day,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TabibiAppBar(title: AppStrings.bookingSummary),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _SummaryCard(
              doctor: doctor, specialty: specialty,
              day: day, time: time,
            ),
            const Spacer(),
            PrimaryButton(
              label: AppStrings.confirmAppt,
              borderRadius: 16,
              onPressed: () => _confirmBooking(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _confirmBooking(BuildContext context) {
    final apptProvider  = context.read<AppointmentProvider>();
    final notifProvider = context.read<NotificationProvider>();

    final appointment = AppointmentModel(
      id:        apptProvider.generateId(),
      doctor:    doctor,
      specialty: specialty,
      date:      day.full,
      time:      time.full,
      status:    AppointmentStatus.upcoming,
      createdAt: DateTime.now(),
    );

    apptProvider.addAppointment(appointment);
    notifProvider.addBookingNotification(doctor.name, day.full, time.full);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookingConfirmationScreen(
          doctor: doctor, day: day, time: time,
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final DoctorModel doctor;
  final String specialty;
  final DaySlot day;
  final TimeSlot time;

  const _SummaryCard({
    required this.doctor, required this.specialty,
    required this.day, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryMid.withValues(alpha: 0.3), width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 12, offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Doctor
          InfoRow(
            icon: Icons.person_outline,
            label: AppStrings.doctorLabel,
            value: doctor.name,
            valueStyle: AppTextStyles.doctorName.copyWith(fontSize: 16),
            iconColor: AppColors.accent,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(specialty,
                style: AppTextStyles.specialtyLabel,
                textAlign: TextAlign.right),
          ),
          const SizedBox(height: 18),
          Divider(color: AppColors.primaryMid.withValues(alpha: 0.3)),
          const SizedBox(height: 10),
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: AppStrings.dateLabel,
            value: day.full,
          ),
          const SizedBox(height: 6),
          InfoRow(
            icon: Icons.access_time_outlined,
            label: AppStrings.timeLabel,
            value: time.full,
          ),
        ],
      ),
    );
  }
}


class BookingConfirmationScreen extends StatelessWidget {
  final DoctorModel doctor;
  final DaySlot day;
  final TimeSlot time;

  const BookingConfirmationScreen({
    super.key, required this.doctor,
    required this.day, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              //  Checkmark 
              _CheckmarkIcon(),
              const SizedBox(height: 32),
              const Text(AppStrings.bookingConfirmed,
                  style: AppTextStyles.heading2, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              const Text(AppStrings.apptConfirmed,
                  style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 36),
              const Divider(thickness: 1, color: AppColors.divider),
              const SizedBox(height: 18),
              // Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.statusConfirmed,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.success, fontWeight: FontWeight.bold,
                      )),
                  const Text(AppStrings.statusLabel,
                      style: AppTextStyles.bodyMedium),
                ],
              ),
              const SizedBox(height: 14),
              // Brief details
              _ConfirmationDetail(doctor: doctor, day: day, time: time),
              const Spacer(flex: 3),
              PrimaryButton(
                label: AppStrings.backToHome,
                borderRadius: 16,
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainShell()),
                  (_) => false,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckmarkIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, height: 120 ,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 3.5),
        color: AppColors.white,
      ),
      child: Center(
        child: CustomPaint(
          size: const Size(64, 64),
          painter: _CheckPainter(),
        ),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 5.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.5)
      ..lineTo(size.width * 0.42, size.height * 0.75)
      ..lineTo(size.width * 0.85, size.height * 0.25);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ConfirmationDetail extends StatelessWidget {
  final DoctorModel doctor;
  final DaySlot day;
  final TimeSlot time;

  const _ConfirmationDetail({
    required this.doctor, required this.day, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          _Row(icon: Icons.person_outline, label: doctor.name, iconColor: AppColors.accent),
          const SizedBox(height: 8),
          _Row(icon: Icons.calendar_today_outlined, label: day.full),
          const SizedBox(height: 8),
          _Row(icon: Icons.access_time_outlined, label: time.full),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  const _Row({required this.icon, required this.label, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(
              fontFamily: 'Cairo', fontSize: 14,
              color: AppColors.textDark, fontWeight: FontWeight.w500,
            )),
        const SizedBox(width: 8),
        Icon(icon, color: iconColor ?? AppColors.primary, size: 18),
      ],
    );
  }
}
