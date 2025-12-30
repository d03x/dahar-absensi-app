import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FingerprintButton extends StatelessWidget {
  final VoidCallback? onFinish;
  final VoidCallback? onTap;

  const FingerprintButton({super.key, this.onFinish, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: onFinish,
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        splashColor: const Color(
          0xFF024574,
        ).withOpacity(0.2), // Warna cipratan biru
        highlightColor: const Color(0xFF024574).withOpacity(0.1),
        child: Container(
          width: 65.w,
          height: 65.w,
          decoration: BoxDecoration(
            color: const Color(0xFF024574).withOpacity(0.08),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: const Color(0xFF024574).withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.fingerprint_outlined,
              color: const Color(0xFF024574), // Warna Icon Biru Utama
              size: 34.w, // Ukuran pas
            ),
          ),
        ),
      ),
    );
  }
}
