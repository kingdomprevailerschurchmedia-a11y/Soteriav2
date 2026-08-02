import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/preview_gallery/preview_gallery_screen.dart';
import 'package:soteria/features/preview_gallery/providers/gallery_providers.dart';

void main() {
  testWidgets('PreviewGalleryScreen refactor maintains functionality', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, _) =>
              const MaterialApp(home: PreviewGalleryScreen()),
        ),
      ),
    );

    // Verify sections exist
    expect(find.text('Design System'), findsOneWidget);
    expect(find.text('EXPLORE CATEGORIES'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Searching updates grid header only', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, _) =>
              const MaterialApp(home: PreviewGalleryScreen()),
        ),
      ),
    );

    // Initial state
    expect(find.text('EXPLORE CATEGORIES'), findsOneWidget);

    // Trigger search
    container.read(gallerySearchQueryProvider.notifier).state = 'Buttons';
    await tester.pump();

    expect(find.text('SEARCH RESULTS'), findsOneWidget);
  });
}
