import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoadingUtil {
  BuildContext context;
  bool _isLoading = false;
  ProgressDialog pr;

  LoadingUtil(this.context);

  void showLoading() {
    if (pr == null) {
      pr = ProgressDialog(context);
    }
    if (!_isLoading) {
      pr.show();
      _isLoading = true;
    }
  }

  void hideLoading() {
    if (pr != null) {
      if (_isLoading) {
        _isLoading = false;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}
