import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class IClock {
  DateTime now();
}

class SystemClock implements IClock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}

final clockProvider = Provider<IClock>((ref) => const SystemClock());
