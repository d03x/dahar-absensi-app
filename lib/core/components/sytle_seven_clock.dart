import 'dart:async';
import 'dart:math';

import 'package:dakos/core/extensions/config_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StyleSevenClock12H extends StatefulWidget {
  final double size;
  final String timezone;
  const StyleSevenClock12H({
    super.key,
    required this.size,
    this.timezone = "Asia/Jakarta",
  });

  @override
  State<StyleSevenClock12H> createState() => _StyleSevenClock12HState();
}

class _StyleSevenClock12HState extends State<StyleSevenClock12H> {
  late Timer _timer;
  // Inisialisasi awal
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    // Set waktu awal
    _updateTime();

    // Update setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _updateTime();
      });
    });
  }

  void _updateTime() {
    _now = DateTime.now();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dayName = DateFormat(
      'EEE',
      'id_ID',
    ).format(_now).toUpperCase(); // SEN
    String monthName = DateFormat(
      'MMM',
      'id_ID',
    ).format(_now).toUpperCase(); // DES
    String digitalTime = DateFormat('HH:mm').format(_now);

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF424242),
          width: widget.size * 0.05,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(child: CustomPaint(painter: ClockFacePainter12H())),

          // Branding Text
          Positioned(
            top: widget.size * 0.22,
            child: Text(
              context.config.appName,
              style: TextStyle(
                fontSize: widget.size * 0.035,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // Digital Time
          Positioned(
            bottom: widget.size * 0.22,
            child: Text(
              digitalTime,
              style: TextStyle(
                fontSize: widget.size * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          Positioned(left: widget.size * 0.18, child: _buildInfoBox(dayName)),

          // KOTAK KANAN (Bulan | Tanggal)
          Positioned(
            right: widget.size * 0.18,
            // Masukkan variabel monthName & dayNumber disini
            child: _buildInfoBox(monthName),
          ),

          // Jarum Jam
          _buildHand(
            angle: ((_now.hour % 12) + _now.minute / 60) * (2 * pi / 12),
            length: widget.size * 0.25,
            width: widget.size * 0.03,
            color: Colors.black,
            isHour: true,
          ),

          // Jarum Menit
          _buildHand(
            angle: (_now.minute + _now.second / 60) * (2 * pi / 60),
            length: widget.size * 0.35,
            width: widget.size * 0.02,
            color: Colors.black,
          ),

          // Jarum Detik
          _buildHand(
            angle: _now.second * (2 * pi / 60),
            length: widget.size * 0.38,
            width: widget.size * 0.008,
            color: const Color(0xFFD32F2F),
          ),

          // Pivot
          Container(
            width: widget.size * 0.035,
            height: widget.size * 0.035,
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // PERBAIKAN WIDGET INFO BOX (Terima 2 parameter: Kiri & Kanan)
  Widget _buildInfoBox(String leftText) {
    return Container(
      width: widget.size * 0.22, // Sedikit diperlebar
      height: widget.size * 0.09,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black87, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                leftText, // Teks Kiri (Misal: SEN)
                style: TextStyle(
                  fontSize: widget.size * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Garis pemisah vertikal
        ],
      ),
    );
  }

  Widget _buildHand({
    required double angle,
    required double length,
    required double width,
    required Color color,
    bool isHour = false,
  }) {
    return Transform.rotate(
      angle: angle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            height: length * 0.24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            width: width,
            height: length,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          SizedBox(height: length),
        ],
      ),
    );
  }
}

class ClockFacePainter12H extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    Paint tickPaint = Paint()
      ..color = Colors.black87
      ..strokeCap = StrokeCap.round;

    TextPainter textPainter = TextPainter(
      textDirection: .ltr, // FIX: Jangan pakai .ltr saja
      textAlign: TextAlign.center,
    );

    for (int i = 0; i < 60; i++) {
      double angle = (i * 6) * (pi / 180) - (pi / 2);
      bool isHourMark = i % 5 == 0;
      double lineLength = isHourMark ? radius * 0.08 : radius * 0.04;
      double lineStart = radius * 0.92;

      tickPaint.strokeWidth = isHourMark ? 3.0 : 1.0;

      double x1 = centerX + lineStart * cos(angle);
      double y1 = centerY + lineStart * sin(angle);
      double x2 = centerX + (lineStart - lineLength) * cos(angle);
      double y2 = centerY + (lineStart - lineLength) * sin(angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);

      if (isHourMark) {
        int hourNum = i ~/ 5;
        if (hourNum == 0) hourNum = 12;

        double textRadius = radius * 0.75;
        double textX = centerX + textRadius * cos(angle);
        double textY = centerY + textRadius * sin(angle);

        textPainter.text = TextSpan(
          text: hourNum.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(textX - textPainter.width / 2, textY - textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
