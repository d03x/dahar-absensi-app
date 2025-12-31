import 'package:dakos/core/extensions/google_fonts_extension.dart';
import 'package:dakos/core/extensions/string_extension.dart';
import 'package:dakos/core/hooks/screenshot_hook_controller.dart';
import 'package:dakos/core/providers/location_service_provider.dart';
import 'package:dakos/features/presensi/view_model/camera_view_model.dart';
import 'package:dakos/features/presensi/view_model/presensi_view_model.dart';
import 'package:dakos/features/presensi/widget/image_screenshot_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PresensiModal extends HookConsumerWidget {
  const PresensiModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(locationServiceProvider);
    final camera = ref.watch(cameraViewModel);
    final presensi = ref.read(presensiProvider.notifier);
    final controller = useScreenshotController();
    final presensiState = ref.watch(presensiProvider);

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
            SizedBox(height: 17.h),
            Row(
              children: [
                Text(presensiState.isLoading.toString()),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    style: ButtonStyle(
                      backgroundColor: .all(CupertinoColors.systemGreen),
                      foregroundColor: .all(
                        CupertinoColors.secondarySystemBackground,
                      ),
                      padding: .all(.all(14.w)),
                      shape: .all(
                        RoundedRectangleBorder(
                          borderRadius: .all(.circular(12.r)),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await presensi.present();
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    label: !presensiState.isLoading
                        ? "Simpan Presensi".toPoppins(
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: .w500,
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                          )
                        : "Loading...".toPoppins(),
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  highlightColor: CupertinoColors.destructiveRed.withValues(
                    alpha: 0.2,
                  ),
                  style: ButtonStyle(
                    foregroundColor: .all(
                      CupertinoColors.destructiveRed.withValues(alpha: 0.6),
                    ),
                    backgroundColor: .all(
                      CupertinoColors.destructiveRed.withValues(alpha: 0.1),
                    ),
                  ),
                  iconSize: 28.w,
                  onPressed: () {
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
}
