import 'package:flutter/material.dart';
import '../design_system/config/soteria_breakpoints.dart';

enum DeviceType { smallPhone, phone, largePhone, tablet, largeTablet, desktop }

class SoteriaResponsive {
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= SoteriaBreakpoints.desktop) return DeviceType.desktop;
    if (width >= SoteriaBreakpoints.largeTablet) return DeviceType.largeTablet;
    if (width >= SoteriaBreakpoints.tablet) return DeviceType.tablet;
    if (width >= SoteriaBreakpoints.largePhone) return DeviceType.largePhone;
    if (width >= SoteriaBreakpoints.smallPhone) return DeviceType.phone;
    return DeviceType.smallPhone;
  }

  static bool isSmallPhone(BuildContext context) =>
      getDeviceType(context) == DeviceType.smallPhone;

  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < SoteriaBreakpoints.tablet;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= SoteriaBreakpoints.tablet &&
        width < SoteriaBreakpoints.desktop;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= SoteriaBreakpoints.desktop;

  static bool isShortScreen(BuildContext context) =>
      MediaQuery.sizeOf(context).height < SoteriaBreakpoints.shortScreen;

  static double adaptive(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? smallMobile,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= SoteriaBreakpoints.desktop && desktop != null) return desktop;
    if (width >= SoteriaBreakpoints.tablet && tablet != null) return tablet;
    if (width < SoteriaBreakpoints.smallPhone && smallMobile != null) {
      return smallMobile;
    }
    return mobile;
  }

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? smallMobile,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= SoteriaBreakpoints.desktop && desktop != null) return desktop;
    if (width >= SoteriaBreakpoints.tablet && tablet != null) return tablet;
    if (width < SoteriaBreakpoints.smallPhone && smallMobile != null) {
      return smallMobile;
    }
    return mobile;
  }
}
