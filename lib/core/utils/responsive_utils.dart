import 'package:flutter/material.dart';

enum ScreenSize { mobile, tablet, desktop }

class ResponsiveUtils {
  ResponsiveUtils._();

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tabletBreakpoint) return ScreenSize.desktop;
    if (width >= mobileBreakpoint) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  static bool isMobile(BuildContext context) =>
      getScreenSize(context) == ScreenSize.mobile;

  static bool isTablet(BuildContext context) =>
      getScreenSize(context) == ScreenSize.tablet;

  static bool isDesktop(BuildContext context) =>
      getScreenSize(context) == ScreenSize.desktop;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  static int gridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tabletBreakpoint) return 3;
    if (width >= mobileBreakpoint) return 2;
    return 1;
  }

  static double maxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tabletBreakpoint) return 900;
    if (width >= mobileBreakpoint) return 700;
    return width;
  }

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tabletBreakpoint) return 32;
    if (width >= mobileBreakpoint) return 24;
    return 16;
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.mobile:
        return mobile;
    }
  }
}
