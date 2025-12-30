import 'package:dakos/core/components/shimmer_box.dart';
import 'package:dakos/core/providers/location_service_provider.dart';
import 'package:dakos/features/presensi/view_model/camera_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_feature_camera/camera.dart';
import "package:flutter_hooks/flutter_hooks.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class PresensiCamera extends HookConsumerWidget {
  const PresensiCamera({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraViewModel);
    final camera = ref.read(cameraViewModel.notifier);
    final isFlashOn = useState(FlashMode.off);
    //fungsi toggle flash
    void toggleFlash() {
      if (isFlashOn.value == FlashMode.off) {
        isFlashOn.value = FlashMode.torch;
        cameraState.controller!.setFlashMode(FlashMode.torch);
      } else {
        isFlashOn.value = FlashMode.off;
        cameraState.controller!.setFlashMode(FlashMode.off);
      }
    }

    final locationService = ref.watch(locationServiceProvider);
    //initialize kamera
    useEffect(() {
      Future.microtask(() {
        camera.initialize();
      });
      return null;
    }, []);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: .center,
        children: [
          if (cameraState.isInitialized && cameraState.controller != null)
            SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: CameraPreview(cameraState.controller!)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .blurXY(
                    begin: 10,
                    end: 0,
                    duration: 100.ms,
                    curve: Curves.easeInQuad,
                  ),
            )
          else
            Center(child: CupertinoActivityIndicator(radius: 20.r)),
          if (cameraState.isInitialized)
            Align(
              alignment: const Alignment(0, -0.2), // Sedikit ke atas tengah
              child: Lottie.asset("assets/lottie/camera_scanning.json"),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 160.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: .topCenter,
                  begin: .bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 160.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: .bottomCenter,
                  begin: .topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          //cek apakah alamat empty
          Positioned(
            top: 60.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    padding: .all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: .circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                if (!locationService.isLoading)
                  Expanded(
                    child: Hero(
                      tag: 'preview-alamat',
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              'maps.show',
                              extra: locationService.value,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .start,
                            children: [
                              Row(
                                mainAxisAlignment: .start,
                                crossAxisAlignment: .start,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.redAccent,
                                    size: 20.w,
                                  ),
                                  Text(
                                    "Lokasi Anda",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                locationService.value!.address.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 14.sp,
                                  fontWeight: .w600,
                                ),
                                overflow: .ellipsis,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerBox(
                          width: 80.w,
                          height: 10.sp,
                          margin: EdgeInsets.only(bottom: 6.h),
                        ),

                        ShimmerBox(
                          width: double.infinity,
                          height: 14.sp,
                          margin: EdgeInsets.only(bottom: 4.h),
                        ),
                        ShimmerBox(width: 150.w, height: 14.sp),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            right: 0,
            left: 0,

            child: !locationService.isLoading
                ? Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: toggleFlash,
                        icon: Icon(
                          isFlashOn.value == FlashMode.torch
                              ? Icons.flash_off
                              : Icons.flash_on,
                          color: Colors.white70,
                          size: 28.w,
                        ),
                      ),
                      Hero(
                        tag: 'present-button',
                        child: Material(
                          clipBehavior: .antiAlias,
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: .circular(100.r),
                            onTap: () async {
                              await camera.takePicture();
                              if (context.mounted) {
                                context.pop();
                              }
                            },
                            child: Container(
                              width: 80.w,
                              height: 80.w,
                              padding: .all(7.w),
                              decoration: BoxDecoration(
                                border: .all(width: 4, color: Colors.white),
                                shape: .circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: .circle,
                                ),
                                child: cameraState.isCapturing
                                    ? CupertinoActivityIndicator()
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  )
                : Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      ShimmerBox(width: 28.h, height: 28.h, isCircle: true),
                      ShimmerBox(width: 80.h, height: 80.h, isCircle: true),
                      SizedBox(width: 48.w),
                    ],
                  ),
          ),

          //cek apakah alamat empty
        ],
      ),
    );
  }
}
