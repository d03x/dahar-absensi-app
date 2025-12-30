import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screenshot/screenshot.dart';

ScreenshotController useScreenshotController() {
  return use(_ScreenshootHookController());
}

class _ScreenshootHookController extends Hook<ScreenshotController> {
  const _ScreenshootHookController();

  @override
  _ScreenshootHookControllerState createState() =>
      _ScreenshootHookControllerState();
}

class _ScreenshootHookControllerState
    extends HookState<ScreenshotController, _ScreenshootHookController> {
  ScreenshotController controller = ScreenshotController();

  @override
  void initHook() {
    super.initHook();
  }

  @override
  ScreenshotController build(BuildContext context) => controller;

  @override
  void dispose() {
    super.dispose();
  }
}
