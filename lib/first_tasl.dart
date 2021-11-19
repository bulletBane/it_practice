import 'dart:math';

main() {
  var rng = Random();
  List<int> list = [];
  for (var i = 0; i < 100; i++) {
    list.add(rng.nextInt(100));
  }

  print('sum: ${list.sum()}');
  print('avg: ${list.avg()}');
  print('min: ${list.min()}');
  print('max: ${list.max()}');
}

extension SumList<T extends num> on List<T> {
  T sum() {
    num sum = 0;
    for (T number in this) {
      sum += number;
    }
    return sum as T;
  }

  T max() {
    return this.reduce((curr, next) => curr > next ? curr : next);
  }

  T min() {
    return this.reduce((curr, next) => curr < next ? curr : next);
  }

  double avg() {
    return this.sum() / this.length;
  }
}
