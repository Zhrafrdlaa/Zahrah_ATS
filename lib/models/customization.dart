/// Pilihan kustomisasi minuman.
enum SizeOption {
  regular('Regular', '12 oz (355 ml)', 0),
  large('Large', '16 oz (473 ml)', 5000);

  const SizeOption(this.label, this.volume, this.extraPrice);
  final String label;
  final String volume;
  final int extraPrice;
}

enum Sweetness {
  normal('Normal', '100%'),
  less('Less', '50%'),
  none('No Sugar', '0%');

  const Sweetness(this.label, this.percent);
  final String label;
  final String percent;
  String get chipLabel => '$label ($percent)';
}

enum IceLevel {
  normal('Normal Ice'),
  less('Less Ice'),
  hot('Hangat');

  const IceLevel(this.label);
  final String label;
}

enum PaymentMethod {
  qris('QRIS & Dompet Digital', 'GoPay, OVO, ShopeePay, BCA, Mandiri'),
  cash('Bayar di Kasir (Cash / Kartu)', 'Bayar saat mengambil pesanan di gerai');

  const PaymentMethod(this.label, this.description);
  final String label;
  final String description;
}
