class Formatters {
  Formatters._();

  /// 22000 -> "Rp 22.000"
  static String rupiah(int value) {
    final digits = value.abs().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return '${value < 0 ? '-' : ''}Rp $buffer';
  }

  /// DateTime -> "09:56"
  static String time(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  /// 898 detik -> "14:58"
  static String countdown(int seconds) =>
      '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
}
