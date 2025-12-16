class NumberFormatter {
  static String formatNumber(int number) {
    if (number < 1000) return number.toString();

    if (number < 1000000) {
      double v = number / 1000;
      return v % 1 == 0 ? '${v.toInt()}K' : '${v.toStringAsFixed(1)}K';
    }

    double v = number / 1000000;
    return v % 1 == 0 ? '${v.toInt()}M' : '${v.toStringAsFixed(1)}M';
  }
}
