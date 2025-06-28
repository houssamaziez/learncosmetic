import 'dart:math';

/// A collection of general-purpose helper functions
class Helpers {
  /// Returns a random integer between [min] and [max]
  static int getRandomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  /// Converts a number of seconds into formatted time (e.g. 01:45:09)
  static String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  /// Rounds a double to 2 decimal places
  static double roundTo2Decimals(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  /// Returns true if the given string is null or empty
  static bool isNullOrEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }

  /// Delays execution for a given number of milliseconds
  static Future<void> delay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  /// Converts a boolean to 'Yes' or 'No'
  static String boolToYesNo(bool value) {
    return value ? 'Yes' : 'No';
  }
}
