import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension GoogleFontsExtension on TextStyle {
  TextStyle useFont(Function(TextStyle?) fontBuilder) {
    return fontBuilder(this);
  }
}

extension TextFont on String {
  Widget toPoppins({TextStyle? style}) {
    return Text(this, style: GoogleFonts.poppins(textStyle: style));
  }
}
