# Implementation Plan - Fix Compilation Errors

The project is currently experiencing a large number of compilation errors, primarily due to missing generated code from `freezed` and `json_serializable`. Many domain models rely on these tools, and their `.freezed.dart` and `.g.dart` files are either missing or out of sync.

## Proposed Changes

### Build & Code Generation
- Run `flutter pub get` to ensure all dependencies are correct (already done, but good to verify).
- Run `dart run build_runner build --delete-conflicting-outputs` to generate the missing model classes, `copyWith` methods, and `fromJson` factories.

### Post-Generation Cleanup
- After code generation, re-evaluate the remaining errors.
- Address any type mismatches (e.g., `num` to `int` conversions) that the compiler might still flag.
- Check for any manual errors in repositories or services where field names might have changed in the domain models but weren't updated in the logic.

## Verification Plan

### Automated Tests
- Run `flutter build apk` (or `flutter build ios`) to verify that the project compiles successfully.
- Run `flutter test` to ensure that the generated code and existing logic work as expected.

### Manual Verification
- Open key files in the editor to ensure that the "Missing getter" errors have disappeared.
