import 'package:flutter/foundation.dart';
import 'dart:io';

class AppConstants {
  static String get rootUrl {
    if (kIsWeb) return 'http://localhost:8001';
    try {
      if (Platform.isAndroid) return 'http://10.0.2.2:8001';
    } catch (_) {}
    return 'http://localhost:8001';
  }

  static String get baseUrl => '$rootUrl/api/v1';

  static String formatImageUrl(String? url, {int? id}) {
    if (url == null || url.isEmpty) {
      return 'https://picsum.photos/500/500?random=${id ?? 0}';
    }
    
    // Replace localhost with 10.0.2.2 for Android emulator
    if (url.contains('localhost')) {
      if (Platform.isAndroid) {
        url = url.replaceAll('localhost', '10.0.2.2');
      }
    }
    if (url!.startsWith('http')) return url;
    
    // Xử lý các đường dẫn phổ biến từ Laravel
    String cleanUrl = url;
    if (url.startsWith('/')) {
      cleanUrl = url.substring(1);
    }
    if (!cleanUrl.startsWith('storage/')) {
      cleanUrl = 'storage/$cleanUrl';
    }
    return '$rootUrl/$cleanUrl';
  }

  static const String tokenKey = 'access_token';
}
