import 'package:flutter/material.dart';
import '../models/app_models.dart';

class AppointmentProvider extends ChangeNotifier {
  final List<AppointmentModel> _appointments = [];

  //  Getters 
  List<AppointmentModel> get all => List.unmodifiable(_appointments);

  List<AppointmentModel> get upcoming =>
      _appointments.where((a) => a.status == AppointmentStatus.upcoming).toList();

  List<AppointmentModel> get completed =>
      _appointments.where((a) => a.status == AppointmentStatus.completed).toList();

  List<AppointmentModel> get cancelled =>
      _appointments.where((a) => a.status == AppointmentStatus.cancelled).toList();

  /// Returns the soonest upcoming appointment (top of list)
  AppointmentModel? get nextAppointment =>
      upcoming.isNotEmpty ? upcoming.first : null;

  int get totalCount => _appointments.length;

  //  Actions 

  /// Adds a new appointment (status = upcoming by default)
  void addAppointment(AppointmentModel appointment) {
    _appointments.insert(0, appointment);
    notifyListeners();
  }

  /// Cancels an appointment by id
  void cancelAppointment(String id) {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _appointments[index] = _appointments[index].copyWith(
        status: AppointmentStatus.cancelled,
      );
      notifyListeners();
    }
  }

  /// Marks an upcoming appointment as completed (for demo)
  void completeAppointment(String id) {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _appointments[index] = _appointments[index].copyWith(
        status: AppointmentStatus.completed,
      );
      notifyListeners();
    }
  }

  /// Pull-to-refresh simulation — just notifies
  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    notifyListeners();
  }

  /// Generates a unique appointment id
  String generateId() =>
      'appt_${DateTime.now().millisecondsSinceEpoch}';
}
