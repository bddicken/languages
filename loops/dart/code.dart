import 'dart:math';
import 'dart:typed_data';

const size = 10000;
void main(List<String> arguments) {
  final u = int.parse(arguments[0]);
  final a = Int32List(size);
  final random = Random();
  final r = random.nextInt(size);

  final multiplier = (100000 ~/ u) + 1;
  final baseSum = (u * multiplier * (multiplier - 1)) ~/ 2;

  for (var i = 0; i < size; i++) {
    a[i] = baseSum + r;
  }

  print(a[r]);
}
