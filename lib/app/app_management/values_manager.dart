class AppDurations {
  static const Duration megaSlow = Duration(seconds: 3);
  static const Duration superSlow = Duration(seconds: 2);
  static const Duration slow = Duration(seconds: 1);
  static const Duration medium = Duration(milliseconds: 750);
  static const Duration fast = Duration(milliseconds: 500);
  static const Duration superFast = Duration(milliseconds: 250);
  static const Duration megaFast = Duration(milliseconds: 100);
  static const Duration timeout = Duration(milliseconds: 60 * 1000);
}
