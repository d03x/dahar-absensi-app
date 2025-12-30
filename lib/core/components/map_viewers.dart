import 'package:dakos/features/presensi/view_model/maps_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' hide Marker;

class MapViewers extends ConsumerWidget {
  final double latitude;
  final double longitude;
  const MapViewers({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude), // London
        initialZoom: 16.5,
        minZoom: 13.0,
        maxZoom: 19.0,
        cameraConstraint: .contain(
          bounds: LatLngBounds(
            LatLng(latitude - 0.05, longitude - 0.05),
            LatLng(latitude + 0.05, longitude + 0.05),
          ),
        ),
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),

      children: [
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(mapsViewViewModel);
            return TileLayer(
              urlTemplate: state,
              userAgentPackageName: 'com.example.app',
              subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
            );
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              width: 55.w,
              height: 55.w,
              child: Lottie.asset("assets/lottie/location_marker.json"),
            ),
          ],
        ),
      ],
    );
  }
}
