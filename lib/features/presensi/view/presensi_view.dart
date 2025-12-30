import 'package:dakos/core/components/sytle_seven_clock.dart';
import 'package:dakos/core/extensions/context_extension.dart';
import 'package:dakos/core/extensions/string_extension.dart';
import 'package:dakos/core/hooks/screenshot_hook_controller.dart';
import 'package:dakos/core/providers/location_service_provider.dart';
import 'package:dakos/features/presensi/view_model/camera_view_model.dart';
import 'package:dakos/features/presensi/widget/image_screenshot_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screenshot/screenshot.dart';

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

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    ScreenshotController controller,
  ) {
    final imagePaths = ref.watch(cameraViewModel);
    final address = ref.watch(locationServiceProvider);

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

  Widget _showAbsensiModal(
    BuildContext context,
    WidgetRef ref,
    ScreenshotController controller,
    CameraState camera,
  ) {
    final address = ref.watch(locationServiceProvider);
    return SizedBox(
      width: 1.sw,
      height: 0.9.sh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.h),
            ClipRRect(
              borderRadius: .circular(10.r),
              child: ImageScreenshotContainer(
                controller: controller,
                location: address.value,
                imagePath: camera.capturedImage!.path,
                datetime: camera.timestamp!.toLocaleTime,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    style: ButtonStyle(
                      backgroundColor: .all(Colors.blueAccent),
                      foregroundColor: .all(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text("SIMPAN PRESENSI"),
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  iconSize: 28.w,
                  onPressed: () {
                    final _ = ref.refresh(cameraViewModel);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
                SizedBox(width: 15.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScreenshotController();
    final camera = ref.watch(cameraViewModel);
    useEffect(() {
      Future.microtask(() {
        if (context.mounted && ModalRoute.of(context)!.isCurrent == true) {
          context.showBottomSheet(
            child: _showAbsensiModal(context, ref, controller, camera),
          );
        }
      });
      return null;
    }, [camera]);
    return Scaffold(
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
      backgroundColor: const Color(0xFFF8F9FD),
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: 29.h),
            SizedBox(width: 1.sw, child: _buildHeader()),
            SizedBox(height: 29.h),
            _buildBody(context, ref, controller),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
