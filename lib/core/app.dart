import 'package:dakos/core/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: routes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            useMaterial3: true,

            appBarTheme: AppBarTheme(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 2, 46, 82),
              iconTheme: IconThemeData(
                applyTextScaling: true,
                color: Colors.white,
              ),
              titleTextStyle: GoogleFonts.poppins().copyWith(
                fontSize: 16.sp,
                fontWeight: .bold,
              ),
              titleSpacing: 0,
            ),
            scaffoldBackgroundColor: CupertinoColors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 2, 46, 82),
            ).copyWith(primary: Color.fromARGB(255, 2, 46, 82)),
          ),
        );
      },
    );
  }
}
