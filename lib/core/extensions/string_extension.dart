import 'package:intl/intl.dart';

extension DateTimeStringExtension on DateTime {
  String get toLocaleDate {
    try {
      String tanggal = DateFormat(
        'EEEE, d MMMM yyyy',
        'id_ID',
      ).format(this).toString();
      return tanggal;
    } catch (e) {
      return "Invalid Timezone";
    }
  }

  String get toLocaleTime {
    try {
      String tanggal = DateFormat('H:mm:s a', 'id_ID').format(this).toString();
      return tanggal;
    } catch (e) {
      return "Invalid Timezone";
    }
  }
}
