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
  
  static const String s3Url = 'https://pub-67fa09494ce44bb18a54b0c9000cc2de.r2.dev';

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
    
    // Xử lý các đường dẫn từ Laravel (Cloudflare R2)
    String cleanUrl = url;
    if (url.startsWith('/')) {
      cleanUrl = url.substring(1);
    }
    
    // Xóa 'storage/' hoặc 'public/' nếu có vì R2 lưu trực tiếp theo path
    if (cleanUrl.startsWith('storage/')) {
      cleanUrl = cleanUrl.substring(8);
    } else if (cleanUrl.startsWith('public/')) {
      cleanUrl = cleanUrl.substring(7);
    }

    return '$s3Url/$cleanUrl';
  }

  static const String tokenKey = 'access_token';
}
