import 'package:dakos/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});
  Widget _buildTextField(
    String labelText, {
    bool obscureText = false,
    IconData? prefixIcon,
  }) {
    return TextFormField(
      cursorColor: Colors.grey,
      obscureText: obscureText,
      style: GoogleFonts.actor(fontSize: 14.sp),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: const Color.fromARGB(255, 85, 85, 85)),
        labelText: labelText,
        filled: true,
        border: OutlineInputBorder(
          borderSide: .none,
          borderRadius: .circular(16.r),
        ),
        prefixIconColor: Colors.grey.withValues(alpha: 0.7),
        contentPadding: .symmetric(vertical: 18.h, horizontal: 10.h),
        fillColor: Colors.grey.withValues(alpha: 0.2),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
          borderRadius: .all(.circular(16.r)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Stack(
              children: [
                Positioned(
                      top: -100.h,
                      right: -50.w,
                      child: Container(
                        width: 300.w,
                        height: 300.h,
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          shape: .circle,
                        ),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      duration: 3.seconds,
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                    ),
                Positioned(
                      bottom: 50.h,
                      left: -50.w,
                      child: Container(
                        width: 200.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          shape: .circle,
                        ),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .moveY(duration: 4.seconds, begin: 20, end: 30),

                SafeArea(
                  child: Padding(
                    padding: .all(18.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                              "WELLCOME BACK",
                              style: GoogleFonts.actor(
                                fontSize: 14.sp,
                                letterSpacing: 2,
                                fontWeight: .bold,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideX(begin: -0.2),
                        SizedBox(height: 8.h),

                        Text(
                          "Absensi Digital Indonusa. ",
                          style: GoogleFonts.actor(
                            fontSize: 42.sp,
                            fontWeight: .bold,
                            height: 1.1,
                          ),
                        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                        SizedBox(height: 40.h),
                        Container(
                          width: 1.sw,
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                            borderRadius: .all(.circular(15.r)),
                          ),
                          child: Column(
                            children: [
                              _buildTextField(
                                "Email",
                                prefixIcon: Icons.alternate_email,
                              ).animate(delay: 700.ms).moveX(begin: -20),
                              SizedBox(height: 20.h),
                              _buildTextField(
                                "Password",
                                obscureText: true,
                                prefixIcon: Icons.lock,
                              ).animate(delay: 900.ms).moveX(begin: -20),
                              Align(
                                alignment: .topRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Lupa Kata Sandi?",
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),

                              SizedBox(
                                height: 50.h,
                                width: 1.sw,
                                child:
                                    ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: .all(
                                                .circular(16.r),
                                              ),
                                            ),
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            textStyle: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: .w600,
                                            ),
                                          ),
                                          onPressed: () {
                                            ref
                                                .read(authProvider.notifier)
                                                .setLogin();
                                          },
                                          child: Text("Login"),
                                        )
                                        .animate(delay: 900.ms)
                                        .fadeIn()
                                        .shimmer(
                                          duration: 1.seconds,
                                          color: Colors.white24,
                                        )
                                        .slideY(
                                          begin: 0.2,
                                          curve: Curves.easeOut,
                                        ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 300.ms).moveY(begin: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
