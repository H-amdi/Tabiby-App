// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import '../providers/appointment_provider.dart';
import '../providers/notification_provider.dart';
import '../widgets/common_widgets.dart';
import '../models/app_models.dart';
import 'booking_flow_screens.dart';
import 'appointments_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('البداية', style: AppTextStyles.appBarTitle),
        centerTitle: true,
        leading: const Icon(Icons.logout_outlined, color: AppColors.white),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo
              _HeartLogo(),
              const SizedBox(height: 28),
              Text(AppStrings.appName,
                  style: AppTextStyles.appTitle.copyWith(fontSize: 44)),
              const SizedBox(height: 12),
              Text(AppStrings.appTagline,
                  style: AppTextStyles.appSubtitle.copyWith(fontSize: 16),
                  textAlign: TextAlign.center),
              const Spacer(flex: 3),
              PrimaryButton(
                label: AppStrings.login,
                borderRadius: 16,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainShell()),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Heart + ECG Logo
class _HeartLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148, height: 148,
      decoration: BoxDecoration(
        color: AppColors.primaryLight, shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.favorite, color: AppColors.primary.withValues(alpha: 0.18), size: 128),
          CustomPaint(size: const Size(110, 110), painter: _EcgPainter()),
        ],
      ),
    );
  }
}

class _EcgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Heart outline
    final s = size.width / 100;
    final heart = Path()
      ..moveTo(50 * s, 80 * s)
      ..cubicTo(10 * s, 55 * s, 0, 35 * s, 20 * s, 20 * s)
      ..cubicTo(30 * s, 10 * s, 45 * s, 14 * s, 50 * s, 30 * s)
      ..cubicTo(55 * s, 14 * s, 70 * s, 10 * s, 80 * s, 20 * s)
      ..cubicTo(100 * s, 35 * s, 90 * s, 55 * s, 50 * s, 80 * s)
      ..close();
    canvas.drawPath(heart, p);

    // ECG line
    final ecg = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final ecgPath = Path()
      ..moveTo(15 * s, 48 * s)
      ..lineTo(30 * s, 48 * s)
      ..lineTo(36 * s, 33 * s)
      ..lineTo(44 * s, 62 * s)
      ..lineTo(50 * s, 42 * s)
      ..lineTo(58 * s, 48 * s)
      ..lineTo(85 * s, 48 * s);
    canvas.drawPath(ecgPath, ecg);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}


class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  _MainShellState createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final unread = context.watch<NotificationProvider>().unreadCount;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          AppointmentsScreen(),
          NotificationsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppStrings.navHome,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: AppStrings.navAppts,
          ),
          BottomNavigationBarItem(
            icon: BadgedIcon(icon: Icons.notifications_outlined, count: unread),
            activeIcon: BadgedIcon(
                icon: Icons.notifications,
                count: unread,
                iconColor: AppColors.primary),
            label: AppStrings.navNotif,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppStrings.navProfile,
          ),
        ],
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<AppointmentProvider>().refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //  Top bar 
                _HomeTopBar(),
                const SizedBox(height: 22),
                //  Medical banner 
                _MedicalBanner(),
                const SizedBox(height: 22),
                //  Next appointment card 
                _NextAppointmentSection(),
                const SizedBox(height: 22),
                //  Quick actions 
                _QuickActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unread = context.watch<NotificationProvider>().unreadCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Notification bell
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLight, shape: BoxShape.circle,
            ),
            child: Center(
              child: BadgedIcon(
                icon: Icons.notifications_outlined,
                count: unread, iconColor: AppColors.primary,
              ),
            ),
          ),
        ),
        // Greeting
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(AppStrings.greeting, style: AppTextStyles.greetingName),
                Text(AppStrings.howAreYou, style: AppTextStyles.greetingSub),
              ],
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 24, backgroundColor: AppColors.primaryLight,
              child: const Icon(Icons.person, color: AppColors.primary, size: 28),
            ),
          ],
        ),
      ],
    );
  }
}

class _MedicalBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight, AppColors.tealCard],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -25, top: -25,
            child: Container(
              width: 110, height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            right: -30, bottom: -30,
            child: Container(
              width: 130, height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BannerIcon(icon: Icons.medication_outlined, label: 'دواء'),
                _BannerIcon(icon: Icons.local_hospital_outlined, label: 'رعاية'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _BannerIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 58, height: 58,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 8, offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(
              fontFamily: 'Cairo', fontSize: 12,
              color: AppColors.primaryDark, fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}

class _NextAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final next = context.watch<AppointmentProvider>().nextAppointment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SectionHeader(title: AppStrings.nextAppt, icon: Icons.schedule),
        const SizedBox(height: 12),
        if (next == null)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: const Center(
              child: Text(
                AppStrings.noUpcoming,
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.textMedium),
              ),
            ),
          )
        else
          _UpcomingCard(appointment: next),
      ],
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _UpcomingCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryMid],
          begin: Alignment.centerRight, end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12, offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appointment.time,
                  style: const TextStyle(
                    fontFamily: 'Cairo', fontSize: 15,
                    fontWeight: FontWeight.bold, color: AppColors.white,
                  )),
              Text(appointment.date,
                  style: TextStyle(
                    fontFamily: 'Cairo', fontSize: 12,
                    color: AppColors.white.withValues(alpha: 0.8),
                  )),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(appointment.doctor.name,
                  style: const TextStyle(
                    fontFamily: 'Cairo', fontSize: 15,
                    fontWeight: FontWeight.bold, color: AppColors.white,
                  )),
              Text(appointment.specialty,
                  style: TextStyle(
                    fontFamily: 'Cairo', fontSize: 12,
                    color: AppColors.white.withValues(alpha: 0.8),
                  )),
            ],
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.white.withValues(alpha: 0.2),
            child: Text(
              appointment.doctor.initials,
              style: const TextStyle(
                fontFamily: 'Cairo', color: AppColors.white,
                fontSize: 15, fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SectionHeader(title: 'الإجراءات السريعة'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ChooseSpecialtyScreen()),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12, offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: AppColors.white),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(AppStrings.bookNew,
                        style: AppTextStyles.heading3.copyWith(color: AppColors.white)),
                    const SizedBox(height: 2),
                    Text(AppStrings.bookNewSub,
                        style: TextStyle(
                          fontFamily: 'Cairo', fontSize: 12,
                          color: AppColors.white.withValues(alpha: 0.8),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryMid.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 20),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(AppStrings.myAppointments,
                        style: AppTextStyles.heading3.copyWith(color: AppColors.primaryDark)),
                    const SizedBox(height: 2),
                    Text(AppStrings.myApptSub, style: AppTextStyles.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
