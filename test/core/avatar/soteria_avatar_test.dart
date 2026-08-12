import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/presentation/widgets/avatar_frame.dart';
import 'package:soteria/core/avatar/domain/avatar.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, __) => MaterialApp(
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  group('SoteriaAvatar', () {
    const testAvatar = Avatar(
      id: 'test',
      name: 'test',
      displayName: 'Test',
      assetPath: 'assets/avatars/athena.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.common,
    );

    testWidgets('renders avatar image when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const SoteriaAvatar(avatar: testAvatar, size: 64),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders online indicator when isOnline is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const SoteriaAvatar(avatar: testAvatar, size: 64, isOnline: true),
        ),
      );

      // Online indicator is a Container in a Stack
      expect(find.byType(Positioned), findsOneWidget);
    });

    testWidgets('renders rank frame when rank is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const SoteriaAvatar(avatar: testAvatar, size: 64, rank: 1),
        ),
      );

      final avatarFrame = tester.widget<AvatarFrame>(find.byType(AvatarFrame));
      expect(avatarFrame.style, AvatarFrameStyle.gold);
    });
   group('AvatarFrame', () {
    testWidgets('renders child', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AvatarFrame(
            size: 64,
            style: AvatarFrameStyle.gold,
            child: Text('CHILD'),
          ),
        ),
      );

      expect(find.text('CHILD'), findsOneWidget);
    });

    testWidgets('renders lock icon when style is locked', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AvatarFrame(
            size: 64,
            style: AvatarFrameStyle.locked,
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byIcon(Icons.lock_rounded), findsOneWidget);
    });
  });
  });
}
