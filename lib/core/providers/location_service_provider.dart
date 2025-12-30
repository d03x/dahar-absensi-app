import 'package:dakos/core/services/GeolocatorService.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationModel extends Equatable {
  final Position? location;
  final String address;
  final Placemark place;
  const LocationModel({
    this.location,
    required this.place,
    required this.address,
  });

  LocationModel copyWith({
    Position? location,
    Placemark? place,
    String? address,
  }) {
    return LocationModel(
      place: place ?? this.place,
      location: location ?? this.location,
      address: address ?? this.address,
    );
  }

  @override
  List get props => [address, place, location];
}

final locationServiceProvider = FutureProvider<LocationModel>((ref) async {
  final locationService = LocationService();
  Position position = await locationService.getGeoLocationPosition();
  Placemark place = await locationService.getAddressFromLongLat(position);
  final address =
      "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  return LocationModel(address: address, place: place, location: position);
});
