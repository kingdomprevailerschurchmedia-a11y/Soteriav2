import 'dart:async';

class CountdownService {
  Timer? _timer;
  final _controller = StreamController<int>.broadcast();

  Stream<int> get stream => _controller.stream;

  void start(int seconds) {
    _timer?.cancel();
    int current = seconds;
    _controller.add(current);
<<<<<<< HEAD

=======
    
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (current > 0) {
        current--;
        _controller.add(current);
      } else {
        _timer?.cancel();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
