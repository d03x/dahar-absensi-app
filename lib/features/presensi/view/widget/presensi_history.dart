import 'package:dakos/core/extensions/context_extension.dart';
import "package:dakos/core/extensions/google_fonts_extension.dart";
import 'package:dakos/features/presensi/view/view_model/presensi_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TypePresensi { masuk, istirahat, keluar }

class AbsenTimeLineModel {
  final TypePresensi type;
  final String time;
  final String status;

  AbsenTimeLineModel({
    required this.type,
    required this.time,
    required this.status,
  });
}

class PresensiHistory extends HookConsumerWidget {
  final List<AbsenTimeLineModel> absenTimeLineModel = [
    AbsenTimeLineModel(
      type: TypePresensi.masuk,
      time: "07:59 WIB",
      status: "Tepat Waktu",
    ),
    AbsenTimeLineModel(
      type: TypePresensi.istirahat,
      time: "012:59 WIB",
      status: "Tepat Waktu",
    ),
    AbsenTimeLineModel(
      type: TypePresensi.keluar,
      time: "07:59 WIB",
      status: "Tepat Waktu",
    ),
  ];

  PresensiHistory({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final presensiState = ref.read(presensiViewModel.notifier);
    final historyPresensi = ref.watch(presensiHistoryProvider);

    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .start,
      children: [
        IconButton(
          onPressed: () {
            ref.read(presensiHistoryProvider.notifier).fetchPresensiHistory();
          },
          icon: Icon(Icons.refresh),
        ),
        Padding(
          padding: .symmetric(horizontal: 20.sp),
          child: "History Presensi".toPoppins(
            style: TextStyle(
              fontWeight: .w500,
              fontSize: context.textTheme.labelLarge!.fontSize,
            ),
          ),
        ),
        SizedBox.fromSize(size: .fromHeight(5.h)),
        historyPresensi.when(
          data: (data) => _buildFooter(),
          error: (error, stackTrace) => Text("ERROR: ${error.toString()}"),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  Color _getTypeColor(TypePresensi type) {
    if (TypePresensi.masuk == type) return Colors.green;
    if (TypePresensi.keluar == type) return Colors.red;
    if (TypePresensi.istirahat == type) return Colors.orange;
    return Colors.blue;
  }

  IconData _getTypeIcon(TypePresensi type) {
    if (type == TypePresensi.masuk) return Icons.login_rounded;
    if (type == TypePresensi.keluar) return Icons.logout_rounded;
    if (type == TypePresensi.istirahat) return Icons.coffee_rounded;
    return Icons.history;
  }

  Widget _buildFooter() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: absenTimeLineModel.length,
      separatorBuilder: (c, i) => SizedBox(height: 12.h), // Jarak antar kartu
      itemBuilder: (context, index) {
        final data = absenTimeLineModel[index];
        final color = _getTypeColor(data.type);
        return ListTile(
          onTap: () {
            context.pushNamed('presensi.camera');
          },
          dense: true,
          leading: Container(
            padding: .all(9.w),
            decoration: BoxDecoration(
              shape: .circle,
              color: color.withValues(alpha: 0.3),
            ),
            child: Icon(_getTypeIcon(data.type), color: color),
          ),
          title: data.type.name.toPoppins(
            style: TextStyle(fontWeight: .w500, color: Colors.black87),
          ),
          subtitle: Text(
            data.time,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          ),
          trailing: data.status.toPoppins(
            style: TextStyle(fontSize: 11.sp, color: _getTypeColor(data.type)),
          ),
        );
      },
    );
  }
}
