/*
  Provider for executing actions such as upvote, posting & such.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionsProvider with ChangeNotifier {
  bool _isLoading = false;

  startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
