import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DeviceType {
  smallPhone('Small Phone', Size(320, 568)),
  iphone('iPhone', Size(390, 844)),
  pixel('Pixel', Size(411, 891)),
  tablet('Tablet', Size(768, 1024)),
  foldable('Foldable', Size(673, 841));

  final String name;
  final Size size;
  const DeviceType(this.name, this.size);
}

class DeviceSimulator extends StatelessWidget {
  final DeviceType device;
  final bool isLandscape;
  final Widget child;

  const DeviceSimulator({
    super.key,
    required this.device,
    required this.isLandscape,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = isLandscape ? device.size.flipped : device.size;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 12,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: size,
              padding: EdgeInsets.only(
                top: isLandscape ? 0 : 44,
                bottom: isLandscape ? 21 : 34,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
