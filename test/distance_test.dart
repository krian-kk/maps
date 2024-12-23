import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  test("Calculate distance between two locations", () {
    final distance = Geolocator.distanceBetween(
      51.5074,
      -0.1278,
      40.7128,
      -74.0060,
    );
    expect(distance, greaterThan(0));
  });
}
