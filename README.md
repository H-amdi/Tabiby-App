# موعدي — Tabibi 🏥

تطبيق حجز مواعيد طبية مبني بـ Flutter، يتيح للمستخدم حجز مواعيد مع الأطباء، متابعة مواعيده، واستعراض الإشعارات — بدون أي خادم أو قاعدة بيانات.

---


---

## المميزات الرئيسية

- **حجز مواعيد** — اختيار تخصص ← طبيب ← تاريخ ← وقت ← تأكيد
- **إدارة المواعيد** — عرض القادمة / المكتملة / الملغاة مع إمكانية الإلغاء
- **الإشعارات** — إشعار تلقائي عند الحجز والإلغاء مع عداد غير المقروءة
- **الملف الشخصي** — بيانات شخصية وطبية قابلة للتعديل
- **الطوارئ** — اتصال سريع بالطوارئ والإسعاف
- **RTL كامل** — دعم اللغة العربية في كل الشاشات

---



> لا يوجد API — لا Firebase — لا قاعدة بيانات. جميع البيانات في الذاكرة فقط.

---

## هيكل المشروع

```
lib/
├── main.dart                        ← نقطة الدخول + MultiProvider
│
├── constants/
│   ├── app_colors.dart              ← جميع الألوان
│   ├── app_text_styles.dart         ← جميع أنماط النصوص
│   └── app_strings.dart             ← جميع النصوص العربية
│
├── theme/
│   └── app_theme.dart               ← إعدادات Material 3
│
├── models/
│   └── app_models.dart              ← SpecialtyModel, DoctorModel,
│                                       AppointmentModel, NotificationModel,
│                                       UserProfileModel, DaySlot, TimeSlot
│
├── data/
│   └── dummy_data.dart              ← بيانات وهمية ثابتة (8 تخصصات، 6 أطباء)
│
├── providers/
│   ├── appointment_provider.dart    ← إضافة / إلغاء / فلترة المواعيد
│   ├── notification_provider.dart   ← إضافة / قراءة / مسح الإشعارات
│   └── profile_provider.dart        ← بيانات المستخدم وتعديلها
│
├── widgets/
│   ├── common_widgets.dart          ← PrimaryButton, AppSearchBar,
│   │                                   EmptyStateWidget, StatusBadge...
│   └── app_widgets.dart             ← SpecialtyCard, DoctorCard,
│                                       AppointmentCard, NotificationTile...
│
└── screens/
    ├── splash_home_screen.dart      ← SplashScreen + MainShell + HomeScreen
    ├── booking_flow_screens.dart    ← ChooseSpecialty + Doctor + Appointment
    ├── booking_screens.dart         ← BookingSummary + BookingConfirmation
    ├── appointments_screen.dart     ← قائمة المواعيد (3 تبويبات)
    ├── notifications_screen.dart    ← قائمة الإشعارات
    ├── profile_screen.dart          ← الملف الشخصي
    ├── edit_profile_screen.dart     ← تعديل البيانات
    └── line_busy_screen.dart        ← شاشة الخط مشغول
```

---

## تدفق الحجز

```
SplashScreen
     ↓
HomeScreen  ──────────────────→  AppointmentsScreen
     ↓                                NotificationsScreen
ChooseSpecialtyScreen                  ProfileScreen
     ↓
ChooseDoctorScreen
     ↓
ChooseAppointmentScreen
     ↓
BookingSummaryScreen  →  يضيف موعد في AppointmentProvider
     ↓                   يضيف إشعار في NotificationProvider
BookingConfirmationScreen
     ↓
HomeScreen  (تتحدث تلقائياً بـ Provider)
```

---

## إدارة الحالة

يستخدم التطبيق **Provider** مع ثلاثة Providers مستقلة:

```dart
// main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AppointmentProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ],
)
```

| Provider | البيانات | الأحداث |
|---|---|---|
| `AppointmentProvider` | قائمة المواعيد | `addAppointment()` / `cancelAppointment()` |
| `NotificationProvider` | قائمة الإشعارات | `addBookingNotification()` / `markAsRead()` / `clearAll()` |
| `ProfileProvider` | بيانات المستخدم | `updateProfile()` |

---

## تشغيل المشروع

```bash
# 1. تثبيت الحزم
flutter pub get

# 2. تشغيل التطبيق
flutter run

# 3. بناء APK
flutter build apk --release
```

**متطلبات:**
- Flutter SDK ≥ 3.19
- Dart ≥ 3.3
- Android SDK أو iOS Simulator

---

---

## المطوّر
ENG/ Hamdi Najeeb Hassan
**Tabibi App** — مشروع أكاديمي  
هندسة البرمجيات — Flutter Development  
