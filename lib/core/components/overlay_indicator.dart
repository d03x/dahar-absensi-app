import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverlayIndicator {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;
  BuildContext context;
  OverlayIndicator({required this.context});
  void show() {
    if (_isShowing && _overlayEntry != null) {
      return;
    }
    _isShowing = true;
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(width: 1.sw, height: 1.sw, color: Colors.red),
        );
      },
    );
    if (_overlayEntry != null) {
      try {
        Overlay.of(context).insert(_overlayEntry!);
      } catch (e) {
        _isShowing = false;
        _overlayEntry = null;
      }
    }
  }

  void hide() {
    if (!_isShowing && null == _overlayEntry) {
      return;
    }
    try {
      _overlayEntry!.remove();
    } catch (e) {
      _isShowing = false;
      _overlayEntry = null;
    }
  }
}
