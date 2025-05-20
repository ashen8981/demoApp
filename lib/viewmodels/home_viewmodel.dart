import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import '../../services/storage_service.dart';
import '../../models/user_model.dart';

class HomeViewModel extends ChangeNotifier {
  String? username;

  HomeViewModel() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    UserModel? user = await StorageService().getUser();
    if (user != null) {
      username = user.firstName; // username as firstname
      notifyListeners();
    }
  }

  void exitApp(BuildContext context) {
    if (kIsWeb) {
      // For web, you can't close the app, so maybe show a snackbar or navigate
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot close the app on web")),
      );
    } else {
      // On mobile, exit the app
      SystemNavigator.pop();
    }
  }
}
