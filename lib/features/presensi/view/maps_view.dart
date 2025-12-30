import 'package:dakos/core/components/map_viewers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

// --- Models ---
class MapsTile {
  static String satelite = 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}';
  static String normal = 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
  static String terrain = 'https://mt1.google.com/vt/lyrs=p&x={x}&y={y}&z={z}';
  static String roadmap = 'https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}';
  static String roadOnly = 'https://mt1.google.com/vt/lyrs=h&x={x}&y={y}&z={z}';
}

class MapsModeItem {
  final String url;
  final String name;
  final String icon;

  MapsModeItem({required this.icon, required this.name, required this.url});
}

class MapsView extends HookConsumerWidget {
  final String? alamat;
  final Position? position;

  MapsView({super.key, this.alamat, this.position});

  final List<MapsModeItem> _items = [
    MapsModeItem(
      icon: 'assets/maps_mode_icon/default.png',
      name: "Standard",
      url: MapsTile.normal,
    ),
    MapsModeItem(
      icon: 'assets/maps_mode_icon/satelite.png',
      name: "Satelite",
      url: MapsTile.satelite,
    ),
    MapsModeItem(
      icon: 'assets/maps_mode_icon/medan.png',
      name: "Terrain",
      url: MapsTile.terrain,
    ),
    MapsModeItem(
      icon: 'assets/maps_mode_icon/lalu_lintas.png',
      name: "Road Only",
      url: MapsTile.roadOnly,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copyToclipBoard = useCopyToClipboard();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          if (position != null)
            Positioned.fill(
              child: MapViewers(
                latitude: position!.latitude,
                longitude: position!.longitude,
              ),
            )
          else ...[
            Container(
              color: Colors.grey[200],
              child: Center(child: Text("Lokasi Tidak Ditemukan")),
            ),
          ],

          if (alamat!.isNotEmpty)
            Positioned(
              bottom: 30.h,
              left: 20.w,
              right: 20.w,
              child: Hero(
                tag: "preview-alamat",
                child:
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: .all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                          borderRadius: .all(.circular(16.r)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: .circle,
                                  ),
                                  child: Lottie.asset(
                                    "assets/lottie/location_marker.json",
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Lokasi Terdeteksi",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              alamat.toString(),
                              overflow: .ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                height: 1.4,

                                fontWeight: .w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            position != null
                                ? Container(
                                    padding: .symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: .all(.circular(7.sp)),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${position!.latitude.toStringAsFixed(6)}, ${position!.longitude.toStringAsFixed(6)}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            copyToclipBoard.copy(
                                              "${position!.latitude.toStringAsFixed(6)}, ${position!.longitude.toStringAsFixed(6)}",
                                            );
                                          },
                                          child: Icon(
                                            Icons.copy,
                                            size: 16.w,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text("-"),
                          ],
                        ),
                      ),
                    ).animate().moveY(
                      duration: Duration(milliseconds: 300),
                      begin: 0.5,
                      end: 1,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
