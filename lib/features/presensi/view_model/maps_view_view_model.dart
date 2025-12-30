import 'package:dakos/core/extensions/config_extension.dart';
import 'package:flutter_riverpod/legacy.dart';

final mapsViewViewModel = StateProvider((ref) {
  return ref.configs.tileUrlLayoutMaps;
});
