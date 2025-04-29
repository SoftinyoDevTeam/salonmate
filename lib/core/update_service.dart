import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:salonmate/core/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  // Get the appropriate store URL for redirection
  static Future<String> getStoreUrl(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final bundleId = packageInfo.packageName;

    if (Platform.isIOS) {
      // Replace with your actual App Store URL
      return 'https://apps.apple.com/app/id' +
          Provider.of<MateServices>(context, listen: false)
              .salonConfig!
              .data!
              .appStoreLink!;
    } else if (Platform.isAndroid) {
      // Replace with your actual Google Play URL
      return 'https://play.google.com/store/apps/details?id=' + bundleId;
    }
    return '';
  }

  // Check if an update is required comparing the current version and the store version.
  static Future<bool> checkForUpdates() async {
    try {
      // Get current app info
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      // Retrieve the store version from a remote source using Dio
      final String? storeVersion = await _getStoreVersion().toString();
      if (storeVersion != null &&
          _isUpdateRequired(storeVersion, currentVersion)) {
        return true; // Update required
      }

      return false; // No update necessary
    } catch (e) {
      print('Error checking for updates: $e');
      return false; // Assume no update needed on error
    }
  }

  // Compare store version and current version (force update if they differ)
  static bool _isUpdateRequired(String storeVersion, String currentVersion) {
    return storeVersion.trim() != currentVersion.trim();
  }

  // Retrieve the latest version from the App Store for iOS and a manually defined version for Android.
  static Future<String?> _getStoreVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final bundleId = packageInfo.packageName;
    final dio = Dio();
    if (Platform.isIOS) {
      // Replace with your actual bundle ID

      final url = 'https://itunes.apple.com/lookup?bundleId=$bundleId';
      final response = await dio.get(url);
      final dynamic responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        return response.data['results'][0]['version'].toString();
      }
    } else if (Platform.isAndroid) {
      // For Android, you can get the version dynamically via your own API or Remote Config.
      final url =
          'https://play.google.com/store/apps/details?id=$bundleId&hl=en';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final html = response.data.toString();
        final versionRegex = RegExp(r'softwareVersion\">([\d\.]+)\<');
        final match = versionRegex.firstMatch(html);
        if (match != null) {
          return match.group(1);
        }
      }
      return '1.0.1'; // Update this value with the actual latest version from Google Play.
    }
    return null;
  }
}
