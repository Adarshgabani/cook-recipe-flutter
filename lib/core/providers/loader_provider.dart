import 'package:flutter/material.dart';

class LoaderProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  showLoader() {
    _isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    _isLoading = false;
    notifyListeners();
  }
}
