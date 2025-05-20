import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  // Country list
  List<String> _countries = [];
  List<String> get countries => _countries;
  bool _isLoadingCountries = false;
  bool get isLoadingCountries => _isLoadingCountries;

  Future<void> fetchCountries() async {
    _isLoadingCountries = true;
    notifyListeners();
    try {
      _countries = await ApiService().fetchCountries();
    } catch (e) {
      _countries = [];
    } finally {
      _isLoadingCountries = false;
      notifyListeners();
    }
  }

  // Login and Sign-up fields
  String? loginUsername;
  String? loginPassword;
  String? error;

  // Dummy + Registered User Login
  bool validateLogin() {
    if (loginUsername == null || loginUsername!.isEmpty) {
      error = "User Name is required";
      return false;
    }
    if (loginPassword == null || loginPassword!.isEmpty) {
      error = "Password is required";
      return false;
    }

    // Only allow registered user login
    if (loginUsername == registeredUsername &&
        loginPassword == registeredPassword) {
      error = null;
      return true;
    }

    error = "Invalid credentials";
    return false;
  }

  // Sign-Up
  UserModel? _user;
  String? signUpPassword;
  String? confirmPassword;
  bool agreed = false;

  // Store the registered username & password
  String? registeredUsername;
  String? registeredPassword;

  AuthViewModel() {
    // Load saved user data from storage as soon as the ViewModel is created
    loadUserFromStorage();
  }

  /// Load user and password from SharedPreferences on app start
  Future<void> loadUserFromStorage() async {
    final user = await StorageService().getUser();
    final password = await StorageService().getPassword();

    if (user != null && password != null) {
      _user = user;
      registeredUsername = user.firstName; // use firstName as username
      registeredPassword = password;
      notifyListeners();
    }
  }

  /// Set the user model after sign-up and save it to persistent storage
  void setUser({
    required String firstName,
    required String lastName,
    required String gender,
    required String mobile,
    required String email,
    required String country,
  }) async {
    _user = UserModel(
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      mobile: mobile,
      email: email,
      country: country,
    );

    // Use first name as username and password from controller
    registeredUsername = firstName;
    registeredPassword = signUpPassword;

    // Save user and password persistently
    if (_user != null && signUpPassword != null) {
      await StorageService().saveUser(_user!, signUpPassword!);
    }

    notifyListeners();
  }

  String? validateSignUp() {
    if (_user == null ||
        signUpPassword == null ||
        confirmPassword == null ||
        signUpPassword!.isEmpty ||
        confirmPassword!.isEmpty) {
      return "All fields are required.";
    }

    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[-!@#$%^&*+])[A-Za-z\d\-!@#$%^&*+]{8,30}$',
    ).hasMatch(signUpPassword!)) {
      return "Invalid password format.";
    }

    if (signUpPassword != confirmPassword) {
      return "Passwords do not match.";
    }

    if (!agreed) {
      return "You must agree to Terms & Conditions.";
    }

    return null;
  }

  UserModel? get user => _user;
}
