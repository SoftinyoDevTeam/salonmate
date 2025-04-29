import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AppTrackingService {
  static Future<void> requestTrackingPermission() async {
    if (!Platform.isIOS) return;

    // Check if tracking authorization is needed
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;

    // Request tracking authorization if needed
    if (status == TrackingStatus.notDetermined) {
      try {
        await Future.delayed(const Duration(milliseconds: 200));
        await AppTrackingTransparency.requestTrackingAuthorization();
      } catch (e) {
        print('Failed to request tracking authorization: $e');
      }
    }
  }
}
