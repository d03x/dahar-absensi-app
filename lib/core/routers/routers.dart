import 'package:dakos/core/providers/location_service_provider.dart';
import 'package:dakos/core/routers/custom_page_route.dart';
import 'package:dakos/features/auth/provider/auth_provider.dart';
import 'package:dakos/features/auth/view/login_view.dart';
import 'package:dakos/features/auth/view/register_view.dart';
import 'package:dakos/features/home/view/home_view.dart';
import 'package:dakos/features/presensi/view/maps_view.dart';
import 'package:dakos/features/presensi/view/presensi_camera.dart';
import 'package:dakos/features/presensi/view/presensi_view.dart';
import 'package:dakos/features/splash/view/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GoRouter _generateRouter(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        name: 'home',
        builder: (context, state) {
          return HomeView();
        },
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return SplashView();
        },
      ),
      GoRoute(
        path: '/login',
        name: "auth.login",
        builder: (context, state) {
          return LoginView();
        },
      ),
      GoRoute(
        path: '/register',
        name: "auth.register",
        builder: (context, state) {
          return RegisterView();
        },
      ),
      GoRoute(
        path: '/presensi',
        name: "presensi.index",
        pageBuilder: (context, state) {
          return buildTransitionPage(
            context: context,
            state: state,
            child: PresensiView(),
          );
        },
      ),
      GoRoute(
        path: '/presensi/camera',
        name: "presensi.camera",
        pageBuilder: (context, state) {
          return buildTransitionPage(
            context: context,
            state: state,
            child: PresensiCamera(),
          );
        },
      ),
      GoRoute(
        path: '/maps/show',
        name: "maps.show",
        pageBuilder: (context, state) {
          final location = state.extra as LocationModel;
          return buildTransitionPage(
            context: context,
            state: state,
            child: MapsView(
              alamat: location.address,
              position: location.location,
            ),
          );
        },
      ),
    ],
    redirect: (context, state) async {
      final bool isLoggedIn =
          authState.value != null && authState.value != false;

      final String location = state.uri.path;
      final bool isSplash = location.contains("/splash");

      final guestOnly =
          location.contains("/login") || location.contains("/register");
      if (!isLoggedIn) {
        if (isSplash || guestOnly) {
          return null;
        }
        return "/login";
      }
      if (isLoggedIn) {
        if (guestOnly) {
          return "/";
        }
      }
      return null;
    },
  );
}

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  return _generateRouter(ref);
});
