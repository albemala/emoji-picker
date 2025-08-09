import 'package:flutter/material.dart';

// Screen size breakpoints
const double mobileBreakpoint = 720;
const double tabletBreakpoint = 1280;

bool isMobileScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < mobileBreakpoint;
}

bool isTabletScreen(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= mobileBreakpoint && width < tabletBreakpoint;
}

bool isDesktopScreen(BuildContext context) {
  return MediaQuery.of(context).size.width >= tabletBreakpoint;
}
