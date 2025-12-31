import 'package:dakos/core/components/sytle_seven_clock.dart';
import 'package:dakos/core/extensions/context_extension.dart';
import 'package:dakos/core/extensions/string_extension.dart';
import 'package:dakos/features/presensi/view_model/camera_view_model.dart';
import 'package:dakos/features/presensi/widget/presensi_history.dart';
import 'package:dakos/features/presensi/widget/presensi_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PresensiView extends HookConsumerWidget {
  const PresensiView({super.key});
  Widget _buildHeader() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Text(
            DateTime.now().toLocaleDate,
            style: GoogleFonts.poppins().copyWith(
              fontSize: 14.sp,
              fontWeight: .w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Shift Pagi 18.00 - 24.00",
            style: GoogleFonts.poppins().copyWith(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              fontWeight: .w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    //screensho
    return Padding(
      padding: .symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          StyleSevenClock12H(size: 200.w, timezone: "Asia/Jakarta"),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget buildFingerprintButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.pushNamed('presensi.camera');
      },
      icon: Icon(Icons.fingerprint),
      label: Text("Presensi"),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraViewModel);
    useEffect(() {
      Future.microtask(() {
        if (context.mounted && camera.hasImage && context.isCurrentModal) {
          context.showBottomSheet(child: PresensiModal());
        }
      });
      return null;
    }, [camera]);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      floatingActionButton: buildFingerprintButton(context, ref),
      appBar: AppBar(
        title: Text(
          DateTime.now().toLocaleDate,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: .w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: 29.h),
            SizedBox(width: 1.sw, child: _buildHeader()),
            SizedBox(height: 29.h),
            _buildBody(context, ref),
            SizedBox(height: 40.h),
            PresensiHistory(),
          ],
        ),
      ),
    );
  }
}
