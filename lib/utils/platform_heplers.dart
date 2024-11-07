// lib/utils/platform_helper.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PlatformHelper {
  static bool isWeb() => kIsWeb;
  
  static bool isWebDesktop(BuildContext context) {
    return kIsWeb && MediaQuery.of(context).size.width > 1024;
  }
  
  static bool isWebTablet(BuildContext context) {
    return kIsWeb && 
           MediaQuery.of(context).size.width <= 1024 && 
           MediaQuery.of(context).size.width >= 768;
  }
  
  static bool isWebMobile(BuildContext context) {
    return kIsWeb && MediaQuery.of(context).size.width < 768;
  }

  static double getContentWidth(BuildContext context) {
    if (isWebDesktop(context)) {
      return MediaQuery.of(context).size.width * 0.8;
    } else if (isWebTablet(context)) {
      return MediaQuery.of(context).size.width * 0.9;
    }
    return MediaQuery.of(context).size.width;
  }

  static EdgeInsets getContentPadding(BuildContext context) {
    if (isWebDesktop(context)) {
      return EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1);
    } else if (isWebTablet(context)) {
      return EdgeInsets.symmetric(horizontal: 40);
    }
    return EdgeInsets.symmetric(horizontal: 20);
  }
}