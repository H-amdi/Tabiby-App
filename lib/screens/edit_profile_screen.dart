// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../models/app_models.dart';
import '../providers/profile_provider.dart';
import '../widgets/common_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  // Controllers — pre-filled from current profile
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _bloodTypeCtrl;
  late final TextEditingController _allergyCtrl;
  late final TextEditingController _chronicCtrl;
  late final TextEditingController _emergencyContactCtrl;
  late final TextEditingController _emergencyPhoneCtrl;

  @override
  void initState() {
    super.initState();
    // Read current profile once when screen opens
    final profile = context.read<ProfileProvider>().profile;

    _nameCtrl = TextEditingController(text: profile.name);
    _phoneCtrl = TextEditingController(text: profile.phone);
    _emailCtrl = TextEditingController(text: profile.email);
    _bloodTypeCtrl = TextEditingController(text: profile.bloodType);
    _allergyCtrl = TextEditingController(text: profile.allergy);
    _chronicCtrl = TextEditingController(text: profile.chronicDiseases);
    _emergencyContactCtrl = TextEditingController(
      text: profile.emergencyContact,
    );
    _emergencyPhoneCtrl = TextEditingController(text: profile.emergencyPhone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _bloodTypeCtrl.dispose();
    _allergyCtrl.dispose();
    _chronicCtrl.dispose();
    _emergencyContactCtrl.dispose();
    _emergencyPhoneCtrl.dispose();
    super.dispose();
  }

  //  Save action 
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Simulate a short save delay for UX feedback
    await Future.delayed(const Duration(milliseconds: 500));

    // Build updated profile from form values
    final updated = UserProfileModel(
      name: _nameCtrl.text.trim(),
      fileNo: context.read<ProfileProvider>().profile.fileNo,
      phone: _phoneCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      bloodType: _bloodTypeCtrl.text.trim(),
      allergy: _allergyCtrl.text.trim(),
      chronicDiseases: _chronicCtrl.text.trim(),
      emergencyContact: _emergencyContactCtrl.text.trim(),
      emergencyPhone: _emergencyPhoneCtrl.text.trim(),
    );

    // Update provider (in-memory only)
    if (mounted) {
      context.read<ProfileProvider>().updateProfile(updated);

      setState(() => _isSaving = false);

      // Success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'تم حفظ التغييرات بنجاح',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TabibiAppBar(title: AppStrings.editProfile),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            //  Avatar placeholder
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 56,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Personal Info 
            _SectionLabel(
              title: 'المعلومات الشخصية',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            _Field(
              label: 'الاسم الكامل',
              controller: _nameCtrl,
              icon: Icons.badge_outlined,
              required: true,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.phone,
              controller: _phoneCtrl,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.email,
              controller: _emailCtrl,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 24),

            //  Medical Info 
            _SectionLabel(
              title: AppStrings.medicalStatus,
              icon: Icons.medical_information_outlined,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.bloodType,
              controller: _bloodTypeCtrl,
              icon: Icons.water_drop_outlined,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.allergy,
              controller: _allergyCtrl,
              icon: Icons.warning_amber_outlined,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.chronicDiseases,
              controller: _chronicCtrl,
              icon: Icons.monitor_heart_outlined,
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            //  Emergency Contact 
            _SectionLabel(
              title: AppStrings.emergencyContacts,
              icon: Icons.contact_phone_outlined,
            ),
            const SizedBox(height: 12),
            _Field(
              label: 'اسم جهة الاتصال',
              controller: _emergencyContactCtrl,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            _Field(
              label: 'رقم الطوارئ',
              controller: _emergencyPhoneCtrl,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 32),

            //  Save button 
            PrimaryButton(
              label: AppStrings.saveChanges,
              isLoading: _isSaving,
              icon: Icons.save_outlined,
              onPressed: _save,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


class _SectionLabel extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionLabel({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        const SizedBox(width: 8),
        Icon(icon, color: AppColors.primary, size: 20),
      ],
    );
  }
}


class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool required;

  const _Field({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? 'هذا الحقل مطلوب' : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            color: AppColors.textMedium,
          ),
          prefixIcon: Icon(icon, color: AppColors.textLight, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
