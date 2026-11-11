/// Exception khusus agar pesan error mudah ditampilkan ke pengguna.
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

class EmptyCartException implements Exception {
  const EmptyCartException([this.message = 'Keranjang masih kosong.']);
  final String message;
  @override
  String toString() => message;
}
