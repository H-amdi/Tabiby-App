// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../data/dummy_data.dart';
import '../models/app_models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_widgets.dart';
import 'booking_screens.dart';


class ChooseSpecialtyScreen extends StatefulWidget {
  const ChooseSpecialtyScreen({super.key});

  @override
  _ChooseSpecialtyScreenState createState() => _ChooseSpecialtyScreenState();
}

class _ChooseSpecialtyScreenState extends State<ChooseSpecialtyScreen> {
  String _query = '';

  List<SpecialtyModel> get _filtered => DummyData.specialties
      .where((s) => s.name.contains(_query))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TabibiAppBar(title: AppStrings.chooseSpec),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppSearchBar(
              hintText: AppStrings.searchSpecOrClinic,
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: _filtered.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.search_off,
                      message: 'لا توجد نتائج',
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.05,
                      ),
                      itemCount: _filtered.length,
                      itemBuilder: (_, i) => SpecialtyCard(
                        specialty: _filtered[i],
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ChooseDoctorScreen(specialty: _filtered[i]),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChooseDoctorScreen extends StatefulWidget {
  final SpecialtyModel specialty;

  const ChooseDoctorScreen({super.key, required this.specialty});

  @override
  _ChooseDoctorScreenState createState() => _ChooseDoctorScreenState();
}

class _ChooseDoctorScreenState extends State<ChooseDoctorScreen> {
  String _query = '';

  List<DoctorModel> get _doctors {
    final bySpec = DummyData.doctors
        .where((d) => d.specialtyId == widget.specialty.id)
        .toList();
    final list = bySpec.isEmpty ? DummyData.doctors : bySpec;
    if (_query.isEmpty) return list;
    return list.where((d) => d.name.contains(_query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TabibiAppBar(title: AppStrings.chooseDoc),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppSearchBar(
              hintText: AppStrings.searchDoc,
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: 14),
            // Specialty chip
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.specialty.name,
                        style: const TextStyle(
                          fontFamily: 'Cairo', fontSize: 13,
                          color: AppColors.primaryDark, fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(width: 6),
                    Icon(widget.specialty.icon, color: AppColors.primary, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: _doctors.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.person_search,
                      message: 'لا يوجد أطباء متاحون',
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _doctors.length,
                      itemBuilder: (_, i) => DoctorCard(
                        doctor: _doctors[i],
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChooseAppointmentScreen(
                              doctor: _doctors[i],
                              specialty: widget.specialty.name,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChooseAppointmentScreen extends StatefulWidget {
  final DoctorModel doctor;
  final String specialty;

  const ChooseAppointmentScreen({
    super.key, required this.doctor, required this.specialty,
  });

  @override
  _ChooseAppointmentScreenState createState() =>
      _ChooseAppointmentScreenState();
}

class _ChooseAppointmentScreenState extends State<ChooseAppointmentScreen> {
  int _selDay  = 0;
  int _selTime = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TabibiAppBar(title: AppStrings.chooseAppt),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Doctor mini card
                  _DoctorMiniCard(doctor: widget.doctor),
                  const SizedBox(height: 24),

                  // Date
                  const SectionHeader(
                    title: AppStrings.dateSection, icon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 86,
                    child: ListView.separated(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: DummyData.days.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (_, i) => DayPickerCard(
                        day: DummyData.days[i],
                        isSelected: _selDay == i,
                        onTap: () => setState(() => _selDay = i),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Time
                  const SectionHeader(
                    title: AppStrings.timeSection, icon: Icons.access_time,
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(DummyData.timeSlots.length, (i) {
                    return TimeSlotCard(
                      slot: DummyData.timeSlots[i],
                      isSelected: _selTime == i,
                      onTap: () => setState(() => _selTime = i),
                    );
                  }),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          // Continue button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: PrimaryButton(
              label: AppStrings.continueBtn,
              onPressed: _selTime < 0
                  ? null
                  : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookingSummaryScreen(
                          doctor:    widget.doctor,
                          specialty: widget.specialty,
                          day:       DummyData.days[_selDay],
                          time:      DummyData.timeSlots[_selTime],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorMiniCard extends StatelessWidget {
  final DoctorModel doctor;
  const _DoctorMiniCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8, offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(doctor.name, style: AppTextStyles.doctorName),
              const SizedBox(height: 4),
              Text(doctor.specialty, style: AppTextStyles.specialtyLabel),
            ],
          ),
          const SizedBox(width: 12),
          DoctorAvatar(doctor: doctor, radius: 28),
        ],
      ),
    );
  }
}
