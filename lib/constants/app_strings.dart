class AppStrings {
  AppStrings._();

  static const String appName     = 'موعدي';
  static const String appTagline  = 'رعايتكم الصحية تبدأ من هنا';
  static const String login       = 'دخول';

  // Home
  static const String greeting       = 'مرحباً سعيد 👋';
  static const String howAreYou     = 'كيف تشعر اليوم؟';
  static const String bookNew        = 'حجز موعد جديد';
  static const String bookNewSub     = 'احجز موعدك الآن بسهولة';
  static const String myAppointments = 'مواعيدي القادمة';
  static const String myApptSub      = 'استعرض مواعيدك القادمة';
  static const String noUpcoming     = 'لا توجد مواعيد قادمة';
  static const String nextAppt       = 'موعدك القادم';

  // Navigation
  static const String navHome        = 'الرئيسية';
  static const String navAppts       = 'المواعيد';
  static const String navNotif       = 'الإشعارات';
  static const String navProfile     = 'الملف الشخصي';

  // Specialty
  static const String chooseSpec         = 'اختر التخصص';
  static const String searchSpecOrClinic = 'ابحث عن التخصص أو العيادة';

  // Doctor
  static const String chooseDoc  = 'اختر الطبيب';
  static const String searchDoc  = 'ابحث عن الطبيب';

  // Appointment
  static const String chooseAppt    = 'اختر الموعد';
  static const String dateSection   = 'التاريخ';
  static const String timeSection   = 'الوقت المتاح';
  static const String continueBtn   = 'استمرار للتأكيد';

  // Summary / Confirm
  static const String bookingSummary   = 'ملخص الحجز';
  static const String doctorLabel      = 'الطبيب';
  static const String dateLabel        = 'التاريخ';
  static const String timeLabel        = 'الوقت';
  static const String confirmAppt      = 'تأكيد الموعد';
  static const String bookingConfirmed = 'تم تأكيد الحجز بنجاح';
  static const String apptConfirmed    = 'تم تأكيد موعدك الطبي بنجاح';
  static const String statusLabel      = 'الحالة:';
  static const String statusConfirmed  = 'مؤكدة';
  static const String backToHome       = 'العودة للرئيسية';

  // Appointments screen
  static const String apptTitle    = 'مواعيدي';
  static const String upcoming     = 'القادمة';
  static const String completed    = 'المكتملة';
  static const String cancelled    = 'الملغاة';
  static const String cancelAppt   = 'إلغاء الموعد';
  static const String cancelConfirm= 'هل أنت متأكد من إلغاء الموعد مع';
  static const String yes          = 'نعم، إلغاء';
  static const String no           = 'لا، تراجع';
  static const String noAppts      = 'لا توجد مواعيد';
  static const String pullToRefresh= 'اسحب للتحديث';
  static const String apptCancelledMsg = 'تم إلغاء الموعد بنجاح';

  // Notifications
  static const String notifTitle   = 'الإشعارات';
  static const String markAllRead  = 'تحديد الكل كمقروء';
  static const String clearAll     = 'مسح الكل';
  static const String noNotif      = 'لا توجد إشعارات';
  static const String unread       = 'غير مقروء';

  // Profile
  static const String profileTitle       = 'الملف الشخصي';
  static const String userName           = 'سعيد محمد';
  static const String userFileNo         = 'رقم الملف: ١٢٣٣';
  static const String medicalStatus      = 'الحالة الطبية';
  static const String bloodType          = 'فصيلة الدم';
  static const String allergy            = 'الحساسية';
  static const String chronicDiseases    = 'الأمراض المزمنة';
  static const String emergencyContacts  = 'جهات الطوارئ';
  static const String emergencyActions   = 'إجراءات الطوارئ';
  static const String callEmergency      = 'اتصل بالطوارئ';
  static const String callAmbulance      = 'اتصل بالإسعاف';
  static const String editProfile        = 'تعديل الملف';
  static const String saveChanges        = 'حفظ التغييرات';
  static const String phone              = 'رقم الهاتف';
  static const String email              = 'البريد الإلكتروني';

  // Emergency
  static const String lineBusy   = 'الخط مشغول حاول مجدداً';
  static const String retry      = 'إعادة';
  static const String close      = 'إغلاق';
  static const String calling    = 'جارٍ الاتصال...';
  static const String callFailed = 'فشل الاتصال';

  // Status badges
  static const String badgeUpcoming  = 'قادم';
  static const String badgeCompleted = 'مكتمل';
  static const String badgeCancelled = 'ملغى';

  // Days in Arabic
  static const List<String> arabicDays = [
    'السبت','الأحد','الاثنين','الثلاثاء','الأربعاء','الخميس','الجمعة',
  ];
  static const List<String> arabicMonths = [
    '','يناير','فبراير','مارس','أبريل','مايو','يونيو',
    'يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر',
  ];
}
