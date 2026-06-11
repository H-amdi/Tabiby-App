import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../constants/app_colors.dart';

class DummyData {
  DummyData._();

  // Specialties 
  static const List<SpecialtyModel> specialties = [
    SpecialtyModel(
      id: 'eye', name: 'عيادة العيون',
      icon: Icons.visibility_outlined,
      iconColor: Color(0xFF1565C0), bgColor: AppColors.iconBgBlue,
    ),
    SpecialtyModel(
      id: 'heart', name: 'عيادة القلب',
      icon: Icons.favorite_outline,
      iconColor: Color(0xFFC62828), bgColor: AppColors.iconBgRed,
    ),
    SpecialtyModel(
      id: 'bone', name: 'عيادة العظام',
      icon: Icons.accessible_outlined,
      iconColor: Color(0xFF6A1B9A), bgColor: AppColors.iconBgPurple,
    ),
    SpecialtyModel(
      id: 'dental', name: 'عيادة الأسنان',
      icon: Icons.medical_services_outlined,
      iconColor: Color(0xFF00695C), bgColor: AppColors.iconBgTeal,
    ),
    SpecialtyModel(
      id: 'lab', name: 'عيادة مختبرات',
      icon: Icons.science_outlined,
      iconColor: Color(0xFF4527A0), bgColor: AppColors.iconBgPurple,
    ),
    SpecialtyModel(
      id: 'brain', name: 'عيادة المخ',
      icon: Icons.psychology_outlined,
      iconColor: Color(0xFFE65100), bgColor: AppColors.iconBgOrange,
    ),
    SpecialtyModel(
      id: 'emergency', name: 'عيادة الطوارئ',
      icon: Icons.monitor_heart_outlined,
      iconColor: Color(0xFFC62828), bgColor: AppColors.iconBgPink,
    ),
    SpecialtyModel(
      id: 'pediatrics', name: 'عيادة الاطفال',
      icon: Icons.child_care_outlined,
      iconColor: Color(0xFF558B2F), bgColor: AppColors.iconBgGreen,
    ),
  ];

  //  Doctors 
  static const List<DoctorModel> doctors = [
    DoctorModel(
      id: 'd1', name: 'د. أحمد عبدالودود',
      specialty: 'استشاري طب وجراحة عيون',
      specialtyId: 'eye',
      avatarColor: Color(0xFF5C6BC0), initials: 'أع',
      rating: 4.9, reviewCount: 245,
      availableTimes: ['10:00 صباحاً', '12:30 ظهراً', '3:00 عصراً'],
    ),
    DoctorModel(
      id: 'd2', name: 'د. ليلى حسن',
      specialty: 'استشارية أمراض القلب والأوعية',
      specialtyId: 'heart',
      avatarColor: Color(0xFF26A69A), initials: 'له',
      rating: 4.8, reviewCount: 189,
      availableTimes: ['11:00 صباحاً', '1:00 ظهراً', '4:30 عصراً'],
    ),
    DoctorModel(
      id: 'd3', name: 'د. صادق نبيل',
      specialty: 'استشاري جراحة العظام',
      specialtyId: 'bone',
      avatarColor: Color(0xFF8D6E63), initials: 'عخ',
      rating: 4.7, reviewCount: 134,
      availableTimes: ['9:00 صباحاً', '11:30 صباحاً', '2:00 ظهراً'],
    ),
    DoctorModel(
      id: 'd4', name: 'د. حمدي نجيب',
      specialty: 'استشاري جراحة مخ وأعصاب',
      specialtyId: 'brain',
      avatarColor: Color(0xFF42A5F5), initials: 'حن',
      rating: 4.9, reviewCount: 312,
      availableTimes: ['10:00 صباحاً', '12:00 ظهراً', '5:00 مساءً'],
    ),
    DoctorModel(
      id: 'd5', name: 'د. نافع عبدالمعطي',
      specialty: 'أخصائي أسنان',
      specialtyId: 'dental',
      avatarColor: Color(0xFF66BB6A), initials: 'نع',
      rating: 4.6, reviewCount: 98,
      availableTimes: ['8:30 صباحاً', '10:30 صباحاً', '1:30 ظهراً'],
    ),
    DoctorModel(
      id: 'd6', name: 'د. سارة المنصور',
      specialty: 'استشارية طب الأطفال',
      specialtyId: 'pediatrics',
      avatarColor: Color(0xFFF06292), initials: 'سم',
      rating: 4.8, reviewCount: 201,
      availableTimes: ['9:30 صباحاً', '12:00 ظهراً', '3:30 عصراً'],
    ),
  ];

  //  Days 
  static const List<DaySlot> days = [
    DaySlot(dayName: 'السبت',    dayNumber: 1,  month: 'مايو'),
    DaySlot(dayName: 'الأحد',    dayNumber: 2,  month: 'مايو'),
    DaySlot(dayName: 'الاثنين',  dayNumber: 3,  month: 'مايو'),
    DaySlot(dayName: 'الثلاثاء', dayNumber: 4,  month: 'مايو'),
    DaySlot(dayName: 'الأربعاء', dayNumber: 5,  month: 'مايو'),
    DaySlot(dayName: 'الخميس',   dayNumber: 6,  month: 'مايو'),
  ];

  //  Time Slots 
  static const List<TimeSlot> timeSlots = [
    TimeSlot(time: '10:00', period: 'صباحاً'),
    TimeSlot(time: '11:30', period: 'صباحاً'),
    TimeSlot(time: '11:00', period: 'صباحاً'),
    TimeSlot(time: '1:00',  period: 'ظهراً'),
    TimeSlot(time: '2:30',  period: 'ظهراً'),
    TimeSlot(time: '4:00',  period: 'عصراً'),
  ];

  //  Default User Profile 
  static const UserProfileModel defaultProfile = UserProfileModel(
    name:             'صادق نبيل ',
    fileNo:           '١٢٣٣',
    phone:            '0501234567',
    email:            'sadiq@example.com',
    bloodType:        'O+',
    allergy:          'بنسلين',
    chronicDiseases:  'سكر، ضغط',
    emergencyContact: ' صادق نبيل (أب)',
    emergencyPhone:   '730987654',
  );
}
