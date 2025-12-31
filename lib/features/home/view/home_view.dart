import 'package:dakos/core/components/fingerprint_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  Widget _headerHome() {
    return Padding(
      padding: .only(right: 10.w, top: 10.h, left: 10.w),
      child: Row(
        spacing: 10.w,
        children: [
          CircleAvatar(),
          Row(
            children: [
              Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .start,
                children: [
                  Text(
                    "ABSENSI DIGITAL APP",
                    style: GoogleFonts.poppins().copyWith(
                      color: Color(0xffD9D9D9),
                      fontSize: 14.sp,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    "PT. SUKSES JAYA",
                    style: GoogleFonts.poppins().copyWith(
                      color: Color(0xffD9D9D9),
                      fontSize: 12.sp,
                      fontWeight: .w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userCard(BuildContext context) {
    return Padding(
      padding: .only(left: 10.w, right: 10.w),
      child: Container(
        padding: .all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .all(.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: Color(0xffB2B2B2),
              blurRadius: 7.7,
              offset: Offset(0, 2),
              spreadRadius: -2,
            ),
          ],
        ),
        clipBehavior: .none,
        width: 1.sw,
        height: 166.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .start,
              children: [
                CircleAvatar(),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Bahlil Lahadalia, S.T",
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 14.sp,
                        fontWeight: .bold,
                        color: Color(0xff6B6060),
                      ),
                    ),
                    Row(
                      spacing: 5.w,
                      children: [
                        Text(
                          "Divisi HR",
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 12.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: Color(0xff9C9696),
                            borderRadius: .circular(100.r),
                          ),
                        ),
                        Text(
                          "234324235325",
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 12.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 24.h, color: Colors.grey.shade200),
            //ini wkkw
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Waktu Masuk",
                      style: GoogleFonts.aDLaMDisplay().copyWith(
                        fontSize: 12.sp,
                        height: 1.2.h,
                        fontWeight: .w800,
                        color: Color(0xff6B6060),
                      ),
                    ),
                    Text(
                      "08:50 WIB",
                      style: GoogleFonts.aDLaMDisplay().copyWith(
                        fontSize: 32.sp,
                        height: 1.2.h,
                        fontWeight: .w800,
                        color: Color(0xff6B6060),
                      ),
                    ),
                    Text(
                      "Telat 50 Menit",
                      style: GoogleFonts.aDLaMDisplay().copyWith(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),

                Hero(
                  tag: "present-button",
                  child: FingerprintButton(
                    onTap: () {
                      context.pushNamed('presensi.index');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stackedBackground(BuildContext context) {
    return Container(
      width: 10.sw,
      height: 171.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: .only(
          bottomLeft: .circular(10.r),
          bottomRight: .circular(10.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            child:
                Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.1),
                        borderRadius: .all(.circular(100.r)),
                      ),
                      width: 84.w,
                      height: 84.w,
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      duration: 3.seconds,
                      begin: Offset(1, 1),
                      end: Offset(1.2, 1.2),
                    ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            child:
                Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: .all(.circular(100.r)),
                      ),
                      width: 57.w,
                      height: 57.w,
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .moveY(begin: 20, end: 24, duration: 3.seconds),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20.w),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff2D3142),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            height: 280.h,
            child: Stack(
              children: [
                _stackedBackground(context),
                Positioned(
                  top: 32.h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      _headerHome(),
                      SizedBox(height: 24.h),
                      _userCard(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: .symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Statistik Kehadiran",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 14.sp,
                          fontWeight: .bold,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(visualDensity: .compact),
                        onPressed: () {},
                        child: Text(
                          "Selengkapnya",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    padding: .only(top: 4.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true, // Agar tidak error scroll inside scroll
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.w,
                    childAspectRatio: 1.4,
                    children: [
                      _buildStatItem(
                        "Hadir",
                        "24",
                        Colors.green,
                        Icons.check_circle_outline,
                      ),
                      _buildStatItem(
                        "Izin",
                        "20",
                        Colors.blue,
                        Icons.assignment_outlined,
                      ),
                      _buildStatItem(
                        "Alpha",
                        "20",
                        Colors.orange,
                        Icons.cancel_outlined,
                      ),
                      _buildStatItem(
                        "Telat",
                        "10",
                        Colors.red,
                        Icons.access_time,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
