import 'dart:math';

/// Returns a random integer between [min] and [max] (inclusive).
int randomInt(int min, int max) {
  return min + Random().nextInt(max - min + 1);
}

/// Checks if [number] is between [min] and [max] (inclusive).
bool isBetween(int number, int min, int max) {
  return number >= min && number <= max;
}
