import 'dart:math';

final random = Random();

/// Returns a random integer between [min] and [max] (inclusive).
int randomInt(int min, int max) {
  if (min > max) {
    throw ArgumentError('min must be less than or equal to max');
  }
  return min + random.nextInt(max - min + 1);
}

/// Checks if [number] is between [min] and [max] (inclusive).
bool isBetween(int number, int min, int max) {
  if (min > max) {
    throw ArgumentError('min must be less than or equal to max');
  }
  return number >= min && number <= max;
}
