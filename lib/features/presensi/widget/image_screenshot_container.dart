import 'dart:io';

import 'package:dakos/core/providers/location_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

class ImageScreenshotContainer extends StatelessWidget {
  final String imagePath;
  final String datetime;
  final LocationModel? location;
  final ScreenshotController controller;
  const ImageScreenshotContainer({
    super.key,
    required this.datetime,
    required this.controller,
    required this.imagePath,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: SizedBox(
        width: 0.9.sw,
        height: 0.7.sh,
        child: Stack(
          children: [
            // Background foto
            Positioned.fill(
              child: Image.file(File(imagePath), fit: BoxFit.cover),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Text info
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.red),
                      Text(
                        location!.place.subAdministrativeArea.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Text(
                    location!.address,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    datetime,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Lat: ${location!.location!.latitude}  •  Lon: ${location!.location!.longitude}",
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
