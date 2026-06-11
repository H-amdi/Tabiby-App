import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../data/dummy_data.dart';

class ProfileProvider extends ChangeNotifier {
  UserProfileModel _profile = DummyData.defaultProfile;

  UserProfileModel get profile => _profile;

  void updateProfile(UserProfileModel newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  void updateField({
    String? name,
    String? phone,
    String? email,
    String? bloodType,
    String? allergy,
    String? chronicDiseases,
    String? emergencyContact,
    String? emergencyPhone,
  }) {
    _profile = _profile.copyWith(
      name:             name,
      phone:            phone,
      email:            email,
      bloodType:        bloodType,
      allergy:          allergy,
      chronicDiseases:  chronicDiseases,
      emergencyContact: emergencyContact,
      emergencyPhone:   emergencyPhone,
    );
    notifyListeners();
  }
}
