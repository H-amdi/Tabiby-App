import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../providers/profile_provider.dart';
import 'edit_profile_screen.dart';
import 'line_busy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.profileTitle,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.white),
            tooltip: AppStrings.editProfile,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),

            //  Avatar 
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 54,
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.person, color: AppColors.primary, size: 60),
              ),
            ),

            const SizedBox(height: 14),

            //  Name 
            Text(profile.name, style: AppTextStyles.profileName),
            const SizedBox(height: 4),
            Text(
              'رقم الملف: ${profile.fileNo}',
              style: AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 24),

            //Personal Info Card
            _ProfileCard(
              title: 'المعلومات الشخصية',
              icon: Icons.person_outline,
              children: [
                _MedRow(
                  icon: Icons.phone_outlined,
                  label: AppStrings.phone,
                  value: profile.phone,
                ),
                const Divider(color: AppColors.divider, height: 20),
                _MedRow(
                  icon: Icons.email_outlined,
                  label: AppStrings.email,
                  value: profile.email,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Medical Status Card 
            _ProfileCard(
              title: AppStrings.medicalStatus,
              icon: Icons.medical_information_outlined,
              headerColor: AppColors.primary,
              children: [
                _MedRow(
                  icon: Icons.water_drop,
                  iconColor: AppColors.error,
                  label: AppStrings.bloodType,
                  value: profile.bloodType,
                ),
                const Divider(color: AppColors.divider, height: 20),
                _MedRow(
                  icon: Icons.warning_amber,
                  iconColor: const Color(0xFFE65100),
                  label: AppStrings.allergy,
                  value: profile.allergy,
                ),
                const Divider(color: AppColors.divider, height: 20),
                _MedRow(
                  icon: Icons.warning_amber,
                  iconColor: const Color(0xFFE65100),
                  label: AppStrings.chronicDiseases,
                  value: profile.chronicDiseases,
                ),
              ],
            ),

            const SizedBox(height: 16),

            //  Emergency Contacts Card 
            _ProfileCard(
              title: AppStrings.emergencyContacts,
              icon: Icons.contact_phone_outlined,
              children: [
                _MedRow(
                  icon: Icons.person_outline,
                  label: 'جهة الاتصال',
                  value: profile.emergencyContact,
                ),
                const Divider(color: AppColors.divider, height: 20),
                _MedRow(
                  icon: Icons.phone_outlined,
                  label: 'رقم الطوارئ',
                  value: profile.emergencyPhone,
                ),
              ],
            ),

            const SizedBox(height: 28),

            //  Emergency Actions Header 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.emergencyActions,
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 22,
                ),
              ],
            ),

            const SizedBox(height: 14),

            //  Call Emergency (Green) 
            _EmergencyButton(
              label: AppStrings.callEmergency,
              icon: Icons.phone,
              color: AppColors.success,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LineBusyScreen(callType: 'طوارئ'),
                ),
              ),
            ),

            const SizedBox(height: 12),

            //  Call Ambulance (Red) 
            _EmergencyButton(
              label: AppStrings.callAmbulance,
              icon: Icons.local_hospital,
              color: AppColors.error,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LineBusyScreen(callType: 'إسعاف'),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


class _ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final Color? headerColor;

  const _ProfileCard({
    required this.title,
    required this.icon,
    required this.children,
    this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    final isColoredHeader = headerColor != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: isColoredHeader ? headerColor : AppColors.primaryLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isColoredHeader
                        ? AppColors.white
                        : AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  icon,
                  color: isColoredHeader ? AppColors.white : AppColors.primary,
                  size: 20,
                ),
              ],
            ),
          ),
          // Body
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.primaryLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}


class _MedRow extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;

  const _MedRow({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(label, style: AppTextStyles.medicalLabel),
            const SizedBox(height: 2),
            Text(value, style: AppTextStyles.medicalValue),
          ],
        ),
        const SizedBox(width: 10),
        Icon(icon, color: iconColor ?? AppColors.primary, size: 20),
      ],
    );
  }
}


class _EmergencyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _EmergencyButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
          shadowColor: color.withValues(alpha: 0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: AppColors.white, size: 22),
          ],
        ),
      ),
    );
  }
}
