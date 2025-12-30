import 'package:flutter_riverpod/legacy.dart';

class State {
  final bool show;
  final String message;
  State({required this.show, required this.message});
}

final splashMessageProvider = StateProvider<State>(
  (ref) => State(show: false, message: "Menyiapkan aplikasi..."),
);
