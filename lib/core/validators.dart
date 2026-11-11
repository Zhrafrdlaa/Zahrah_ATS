/// Kumpulan validasi input form. Mengembalikan null jika valid.
class Validators {
  Validators._();

  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  static final RegExp _phone = RegExp(r'^(\+62|62|0)8\d{7,11}$');

  static String? emailOrPhone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email / Nomor HP wajib diisi';
    final valid =
        text.contains('@') ? _email.hasMatch(text) : _phone.hasMatch(text);
    return valid ? null : 'Format email / nomor HP tidak valid';
  }

  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return 'Kata sandi wajib diisi';
    if (text.length < 6) return 'Kata sandi minimal 6 karakter';
    return null;
  }
}
