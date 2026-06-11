// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/app_models.dart';
import '../providers/appointment_provider.dart';
import '../providers/notification_provider.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_widgets.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.apptTitle,
            style: TextStyle(
              fontFamily: 'Cairo', fontSize: 20,
              fontWeight: FontWeight.bold, color: AppColors.white,
            )),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white,
          indicatorColor: AppColors.white,
          labelStyle: const TextStyle(
            fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Cairo', fontSize: 14,
          ),
          tabs: const [
            Tab(text: AppStrings.upcoming),
            Tab(text: AppStrings.completed),
            Tab(text: AppStrings.cancelled),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ApptList(status: AppointmentStatus.upcoming, canCancel: true),
          _ApptList(status: AppointmentStatus.completed),
          _ApptList(status: AppointmentStatus.cancelled),
        ],
      ),
    );
  }
}


class _ApptList extends StatelessWidget {
  final AppointmentStatus status;
  final bool canCancel;

  const _ApptList({required this.status, this.canCancel = false});

  List<AppointmentModel> _getList(AppointmentProvider p) {
    switch (status) {
      case AppointmentStatus.upcoming:  return p.upcoming;
      case AppointmentStatus.completed: return p.completed;
      case AppointmentStatus.cancelled: return p.cancelled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppointmentProvider>();
    final list = _getList(provider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: provider.refresh,
      child: list.isEmpty
          ? _EmptyAppts(status: status)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (_, i) {
                final appt = list[i];
                return AppointmentCard(
                  appointment: appt,
                  onCancel: canCancel
                      ? () => _showCancelDialog(context, appt)
                      : null,
                );
              },
            ),
    );
  }

  void _showCancelDialog(BuildContext context, AppointmentModel appt) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'إلغاء الموعد',
          style: TextStyle(
            fontFamily: 'Cairo', fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          '${AppStrings.cancelConfirm} ${appt.doctor.name}؟',
          style: const TextStyle(fontFamily: 'Cairo', color: AppColors.textMedium),
          textAlign: TextAlign.right,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(AppStrings.no,
                style: TextStyle(
                  fontFamily: 'Cairo', color: AppColors.textMedium,
                )),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AppointmentProvider>().cancelAppointment(appt.id);
              context.read<NotificationProvider>()
                  .addCancellationNotification(appt.doctor.name);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(AppStrings.apptCancelledMsg,
                      style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(AppStrings.yes,
                style: TextStyle(fontFamily: 'Cairo', color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}

class _EmptyAppts extends StatelessWidget {
  final AppointmentStatus status;
  const _EmptyAppts({required this.status});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: status.icon,
      message: AppStrings.noAppts,
      subMessage: 'لا توجد مواعيد ${status.label} حالياً',
    );
  }
}
