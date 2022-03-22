import 'package:flutter/cupertino.dart';

class EmailVerificationProvider extends ChangeNotifier {
  bool _isLoading = false;
  get isLoading => _isLoading;

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }
}
