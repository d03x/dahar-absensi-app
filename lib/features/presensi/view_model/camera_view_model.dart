import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feature_camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraState extends Equatable {
  final CameraController? controller;
  final bool isInitialized;
  final XFile? capturedImage;
  final bool isCapturing;
  final DateTime? timestamp;
  const CameraState({
    this.timestamp,
    this.controller,
    this.isCapturing = false,
    this.capturedImage,
    this.isInitialized = false,
  });
  CameraState copyWith({
    CameraController? controller,
    bool? isCapturing,
    XFile? capturedImage,
    bool? isInitialized,
    DateTime? timestamp,
  }) {
    return CameraState(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
      isCapturing: isCapturing ?? this.isCapturing,
      capturedImage: capturedImage ?? this.capturedImage,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List get props => [capturedImage, timestamp, isCapturing, controller];
}

class CameraViewModel extends Notifier<CameraState> {
  @override
  CameraState build() {
    ref.onDispose(() {
      state.controller!.dispose();
      debugPrint("Camera Disposed by Riverpod");
    });
    return CameraState();
  }

  Future<void> takePicture() async {
    state = state.copyWith(isCapturing: true);
    try {
      if (state.controller != null) {
        final img = await state.controller!.takePicture();
        state = state.copyWith(
          capturedImage: img,
          isCapturing: false,
          timestamp: DateTime.now(),
        );
      }
      if (state.controller != null) {
        state.controller!.setFlashMode(.off);
      }
    } catch (e) {
      state = state.copyWith(isCapturing: false);
    }
  }

  void initialize() async {
    try {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        front,
        .veryHigh,
        enableAudio: false,
        imageFormatGroup: .jpeg,
      );
      await controller.initialize();
      controller.setFlashMode(FlashMode.off);
      state = state.copyWith(controller: controller, isInitialized: true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

final cameraViewModel = NotifierProvider<CameraViewModel, CameraState>(() {
  return CameraViewModel();
});
