import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}

extension ColorSchemeExt on BuildContext {
  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }
}

OverlayEntry? _loadingEntry;

extension LoaderContext on BuildContext {
  void showOverlay() {
    if (_loadingEntry != null) return;
    _loadingEntry = OverlayEntry(
      builder: (cotext) {
        return Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.black87.withValues(alpha: 0.8),
            width: 1.sw,
            height: 1.sh,
            child: Center(
              child: SizedBox(
                width: 100.w,
                height: 100.w,
                child: Lottie.asset("assets/lottie/loading.json"),
              ),
            ),
          ),
        );
      },
    );
    try {
      Overlay.of(this).insert(_loadingEntry!);
    } catch (e) {
      _loadingEntry!.remove();
    }
  }

  void hideOverlay() {
    if (_loadingEntry == null) return;
    try {
      _loadingEntry!.remove();
      _loadingEntry = null;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loadingEntry = null;
    }
  }
}

extension Modal on BuildContext {
  bool get isCurrentModal {
    return ModalRoute.of(this)?.isCurrent ?? false;
  }

  Future<dynamic> showBottomSheet({required Widget child}) async {
    if (mounted) {
      return showModalBottomSheet(
        clipBehavior: .none,
        shape: RoundedRectangleBorder(
          borderRadius: .only(
            topLeft: .circular(5.r),
            topRight: .circular(5.r),
          ),
        ),
        isScrollControlled: true,
        context: this,
        builder: (context) {
          return child;
        },
      );
    }
  }
}
